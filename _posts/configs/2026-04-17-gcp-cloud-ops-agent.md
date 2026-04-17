---
layout: post
title: "GCP Cloud Ops Agent"
date: 2026-04-17
excerpt: "GCEへのCloud Ops Agentのインストールとモニタリングメトリクスの収集"
tag: ["gcp", "gce", "monitoring", "cloud ops agent"]
config: true
comments: false
sort_key: "2026-04-17"
update_dates: ["2026-04-17"]
---

# GCP Cloud Ops Agent

## 概要
 - GCEインスタンスのメモリ・ディスク・ネットワーク等のOS内部メトリクスをCloud Monitoringへ送信するエージェント
 - VMにはデフォルトでインストールされていないため、別途導入が必要
 - CPUはエージェントなしでも取得できるが、メモリ・ディスク使用率はエージェントが必要

## インストール

```console
$ curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
$ sudo bash add-google-cloud-ops-agent-repo.sh --also-install
```

## 収集できるメトリクス

| メトリクス | metric.type | エージェント要否 |
|---|---|---|
| CPU使用率 | `compute.googleapis.com/instance/cpu/utilization` | 不要 |
| メモリ使用率 | `agent.googleapis.com/memory/percent_used` | 必要 |
| ディスク使用率 | `agent.googleapis.com/disk/percent_used` | 必要 |
| ネットワーク受信バイト数 | `compute.googleapis.com/instance/network/received_bytes_count` | 不要 |
| ネットワーク送信バイト数 | `compute.googleapis.com/instance/network/sent_bytes_count` | 不要 |

## Cloud Runでメトリクスを定期収集してBigQueryに記録する

Cloud MonitoringのAPIからメトリクスを取得し、BigQueryに書き込むCloud Runの実装例（Dockerfileでコンテナ化してデプロイする）

 - `monitoring_v3.MetricServiceClient` で直近10分間の平均値を取得する
 - `agent.googleapis.com` 系のメトリクスはフィルタに `instance_id` を使う（`instance_name` では取得できない）
 - `compute.googleapis.com` 系のメトリクスはフィルタに `instance_name` を使う

```python
import os
from datetime import datetime, timezone, timedelta

import functions_framework
import googleapiclient.discovery
from google.cloud import bigquery, monitoring_v3

PROJECT = os.environ.get("GCP_PROJECT", "my-project")
ZONE = os.environ.get("GCE_ZONE", "asia-northeast1-a")
BQ_DATASET = os.environ.get("BQ_DATASET", "ops")
BQ_TABLE = os.environ.get("BQ_TABLE", "instance_status_log")


def list_instances(project, zone):
    compute = googleapiclient.discovery.build("compute", "v1")
    result = compute.instances().list(project=project, zone=zone).execute()
    return result.get("items", [])


def get_monitoring_metric(project, metric_type, instance_name, instance_id,
                          extra_filter=""):
    """直近10分間の平均値を返す"""
    client = monitoring_v3.MetricServiceClient()
    now = datetime.now(timezone.utc)
    interval = monitoring_v3.TimeInterval(
        end_time=now,
        start_time=now - timedelta(minutes=10),
    )
    filter_str = f'metric.type = "{metric_type}"'
    if "agent.googleapis.com" in metric_type:
        filter_str += f' AND resource.labels.instance_id = "{instance_id}"'
    else:
        filter_str += f' AND metric.labels.instance_name = "{instance_name}"'
    if extra_filter:
        filter_str += f" AND {extra_filter}"

    results = client.list_time_series(
        request={
            "name": f"projects/{project}",
            "filter": filter_str,
            "interval": interval,
            "view": monitoring_v3.ListTimeSeriesRequest.TimeSeriesView.FULL,
        }
    )
    values = [
        p.value.double_value or p.value.int64_value or 0
        for ts in results
        for p in ts.points
    ]
    return sum(values) / len(values) if values else None


@functions_framework.http
def monitor_instance(request):
    """インスタンスのステータス・各メトリクスをBigQueryに記録する"""
    instances = list_instances(PROJECT, ZONE)
    if not instances:
        return ("No instances found", 200)

    now = datetime.now(timezone.utc)
    bq = bigquery.Client(project=PROJECT)
    table_ref = f"{PROJECT}.{BQ_DATASET}.{BQ_TABLE}"

    rows = []
    for inst in instances:
        name, status, instance_id = inst["name"], inst["status"], inst["id"]
        metrics = {}
        if status == "RUNNING":
            specs = [
                ("cpu_utilization",        "compute.googleapis.com/instance/cpu/utilization", ""),
                ("memory_utilization",     "agent.googleapis.com/memory/percent_used",        'metric.labels.state = "used"'),
                ("disk_utilization",       "agent.googleapis.com/disk/percent_used",          'metric.labels.state = "used" AND metric.labels.device = "/dev/nvme0n1p1"'),
                ("network_received_bytes", "compute.googleapis.com/instance/network/received_bytes_count", ""),
                ("network_sent_bytes",     "compute.googleapis.com/instance/network/sent_bytes_count",     ""),
            ]
            for key, metric_type, extra in specs:
                try:
                    metrics[key] = get_monitoring_metric(PROJECT, metric_type, name, instance_id, extra)
                except Exception as e:
                    print(f"Failed to get {key} for {name}: {e}")
                    metrics[key] = None

        rows.append({
            "timestamp": now.isoformat(),
            "instance_name": name,
            "zone": ZONE,
            "status": status,
            **metrics,
        })

    errors = bq.insert_rows_json(table_ref, rows)
    if errors:
        return (f"BQ insert errors: {errors}", 500)

    summary = ", ".join(f"{r['instance_name']}={r['status']}" for r in rows)
    return (f"{now.isoformat()} | {summary}", 200)
```
