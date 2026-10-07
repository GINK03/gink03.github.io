---
layout: post
title: "dbt セマンティックレイヤー for LLM"
date: 2026-04-06
excerpt: "dbt CoreのMetricFlowとmartのメタ情報をClaude CodeのSkillにまとめ、LLMにBigQueryの分析を正確にさせる手順"
project: false
kaggle: true
tag: ["dbt", "MetricFlow", "LLM", "BigQuery", "semantic layer", "claude code", "agent skills"]
comments: false
sort_key: "2026-10-07"
update_dates: ["2026-10-07","2026-04-06"]
---

## 概要
 - dbt Core と BigQuery のプロジェクトに、LLM（Claude Code）がデータを理解して分析するための専用 Skill を作る手順
 - 指標で答えられる質問は MetricFlow に計算させ、指標にない質問だけ mart のメタ情報を読ませて SQL を書かせる
 - dbt プロジェクトのエージェントにこの記事を読ませ、Skill を作らせる使い方を想定している
 - 人とエージェントの分担は「エージェントに作らせるときの指示」にまとめた
 - コードは参考実装なので、プロジェクトの構成に合わせて読み替える
 - 2026-10 時点の情報で、YAML の書式と `mf` コマンドは dbt-core 1.12.5 と dbt-metricflow 0.15.0（DuckDB アダプタ）で動作を確認した
 - dbt の基本は[dbt記事](/dbt/)、Skill の仕組みは[Claude Agent Skills記事](/claude-agent-skills/)を参照

## 背景

### テーブル定義だけでは正しい SQL にならない

LLM にテーブル名とカラム名だけを渡すと、次の情報が欠けて誤ったクエリを書く

 - フル修飾のテーブル名（`project.dataset.table`）
 - カラムの型（INT64、STRING、BOOL など）
 - テーブルの粒度（1行が何を表すか）
 - 安全に JOIN できるキー
 - やってはいけない使い方（キャンセルを含めたまま売上を合計する、など）
 - 指標の定義（「売上」に何を含めるか）

dbt にはこれらを書く場所がそろっているので、dbt の正式な仕組みで管理して LLM に渡す

### セマンティックレイヤーを先に通す

 - 指標の計算は、LLM に SQL を書かせるより MetricFlow に任せるほうが正確になる
 - dbt Labs のベンチマーク（2026-04）では、セマンティックレイヤー（SL）で答えられる範囲の質問について、SL の正答率が100%、text-to-SQL が62.5%だった（Claude Sonnet 4.6）
 - 足りないモデルを追加した後でも、全体の正答率は text-to-SQL が90.0%、SL が98.2%だった
 - SL は定義していない質問には答えられないので、「まず指標で答え、答えられなければ SQL を書く」の順にする
 - Anthropic の社内事例（2026-06）も同じ順番で、SL を必須の既定ルートにし、生の SQL は SL で答えられないと確かめたときだけ使っている
 - この事例では分析の質問の95%を Claude で自動化し、精度は約95%（Skill なしでは21%）

### 意味は人が決める

 - 同じ Anthropic の事例では、LLM に作らせた指標の定義は、もっともらしいが曖昧さを残したままになり、人が整えた定義より精度が低かった
 - 過去の SQL 数千本を grep できるようにしても、精度の変化は1ポイント未満だった
 - Vercel の text-to-SQL エージェント（2025-12）も、専用ツールをやめてセマンティックレイヤーのファイルを bash で探索させたところ速度と成功率が上がったが、「もともとセマンティックレイヤーがよく文書化されていたから」と注記している
 - 効くのは情報の量ではなく、人が確かめた意味の情報
 - エージェントは下書きまでにして、粒度、禁止事項、指標の定義は人が確定する

## 全体像

```text
models/marts/_marts.yml     config.meta（grain, join_keys, forbidden_uses, pii など）
                            semantic_model と metrics（MetricFlow の定義）
        ↓ dbt parse / dbt docs generate
target/manifest.json        メタ情報、セマンティックモデル、指標
target/catalog.json         BigQuery から取得した列の型
        ↓ build_mart_meta.py
references/mart_meta.json   承認済みの mart だけを LLM 向けにまとめたもの
        ↓
SKILL.md                    指標の質問は mf query、それ以外は mart_meta.json を読んで SQL
```

最終的なファイル構成

```text
<repo>/
├── CLAUDE.md                              # Skill を使うよう短く指示する
├── .claude/skills/analyzing-dbt-marts/
│   ├── SKILL.md                           # 手順と禁止事項
│   ├── references/
│   │   ├── mart_meta.json                 # 生成物（手で編集しない）
│   │   └── glossary.md                    # 人が書く用語集（任意）
│   └── scripts/
│       └── build_mart_meta.py             # manifest + catalog → mart_meta.json
└── dbt/analytics/                         # dbt プロジェクト
    ├── dbt_project.yml
    └── models/
        ├── marts/
        │   ├── _marts.yml                 # config.meta、semantic_model、metrics
        │   └── *.sql
        ├── staging/
        └── utilities/
            ├── metricflow_time_spine.sql
            └── _models.yml                # time_spine の設定
```

 - 旧版では `mart_meta.json` を dbt プロジェクトの直下に置き、CLAUDE.md で「分析の前に読め」と指示していた
 - Skill にすると手順と参照ファイルを1か所にまとめられ、分析の質問のときだけ読み込まれる

## 手順

### 1. dbt のバージョンを確認して MetricFlow を入れる

```bash
dbt --version
pip install "dbt-metricflow[dbt-bigquery]"
mf --version
```

 - セマンティック定義を解析して `target/semantic_manifest.json` に書き出すのは dbt-core 自身で、dbt-metricflow を入れなくても `dbt parse` は通る
 - dbt-metricflow は `mf` コマンド（定義の検証と指標の問い合わせ）を使うために入れる
 - dbt-metricflow は版ごとに対応する dbt-core の範囲が決まっている（0.15.0 は dbt-core 1.11 以上 1.13 未満）ので、入れた後に dbt-core の版が変わっていないか確かめる
 - MetricFlow は 2025-10 に Apache 2.0 ライセンスになった
 - dbt platform を契約しなくても、`mf` で手元から指標を問い合わせられる
 - dbt 1.12 以降は新しい書式、1.11 以前は旧書式でセマンティック定義を書く（手順4）

### 2. time spine を作る

MetricFlow は時間軸の集計に日付の連番テーブル（time spine）を使う

`models/utilities/metricflow_time_spine.sql`

{% raw %}
```sql
{{ config(materialized='table') }}

select date_day
from unnest(generate_date_array(date '2020-01-01', date '2030-12-31', interval 1 day)) as date_day
```
{% endraw %}

`models/utilities/_models.yml`

```yaml
models:
  - name: metricflow_time_spine
    description: "MetricFlow用の日付スパインテーブル"
    time_spine:
      standard_granularity_column: date_day
    columns:
      - name: date_day
        granularity: day
```

 - dbt 1.9 以降は、モデルの YAML の `time_spine` で time spine を宣言し、`standard_granularity_column` に指定した列に `granularity` を付ける
 - 旧方式は `metricflow_time_spine.sql` を YAML の設定なしで置く方法で、非推奨になっている（`MFTimespineWithoutYamlConfigurationDeprecation`）

### 3. mart に `config.meta` を書く

LLM に使わせる mart ごとに、SQL だけでは分からない情報を `config.meta` に書く

```yaml
models:
  - name: fct_orders
    description: "受注ファクト（キャンセルと保留を含む全注文）"
    config:
      meta:
        approved_for_ai: true
        grain: "1行 = 1注文"
        business_name: "受注データ"
        join_keys: ["order_id", "customer_id"]
        recommended_filters: ["ordered_at", "status"]
        forbidden_uses: "status = 'cancelled' を含めたまま金額を合計しない"
        pii: false
        owner: "data-team@example.com"
    columns:
      - name: amount
        description: "注文金額（税抜、円）"
```

| フィールド | 必須 | 書く内容 | 決める人 |
|---|---|---|---|
| `approved_for_ai` | ○ | LLM に使わせてよいか（`true` の mart だけが `mart_meta.json` に入る） | 人 |
| `grain` | ○ | 1行が何を表すか | 人（SQL やテストから下書きしてよい） |
| `join_keys` | ○ | 主キーと、他の mart への外部キー | エージェントが下書きし、人が確認する |
| `pii` | ○ | PII の有無と扱い（ない場合は `false`） | 人 |
| `forbidden_uses` | 落とし穴があるとき | やってはいけない集計や解釈 | 人 |
| `business_name` | 任意 | 非技術者向けの名前 | 人 |
| `recommended_filters` | 任意 | 絞り込みによく使う列 | エージェントが下書きしてよい |
| `owner` | 任意 | 問い合わせ先 | 人 |

 - dbt 1.10 以降は `meta` を `config` の下に書き、モデル直下の `meta` は非推奨
 - 根拠のある内容だけを書き、推測で埋めない
 - 分からない項目は `TODO` にして人に確認する
 - カラムの `description` は列名の言い換えにせず、単位、取りうる値、注意点を書く
 - `persist_docs` を有効にすると、description が BigQuery のテーブルと列の説明にも入る（[dbt記事](/dbt/)を参照）

### 4. セマンティックモデルと指標を書く

 - `entities` は JOIN の起点になるキーで、`primary`（主キー）と `foreign`（外部キー）を区別する
 - `dimensions` は分析の切り口（WHERE や GROUP BY に使う列）で、日時の列は `time`、それ以外は `categorical` にする
 - 指標（metrics）は「何をどう集計するか」の定義で、名前と description が LLM にとっての用語集になる
 - LLM に使わせる mart にはすべてセマンティック定義を書く（定義のない mart は MetricFlow から JOIN できない）

#### dbt 1.12 以降（新しい書式）

 - セマンティックモデルはモデルの YAML の中に、entity と dimension は列に書く
 - measures は非推奨になり、`agg` と `expr` を直接持つ simple metric に置き換わった

{% raw %}
```yaml
models:
  - name: fct_orders
    config:
      meta:
        approved_for_ai: true  # 手順3のフィールド
    semantic_model:
      enabled: true
    agg_time_dimension: ordered_at
    columns:
      - name: order_id
        entity:
          name: order
          type: primary
      - name: customer_id
        entity:
          name: customer
          type: foreign
      - name: ordered_at
        granularity: day
        dimension:
          type: time
      - name: status
        dimension:
          type: categorical
    metrics:
      - name: order_count
        label: "注文数"
        description: "キャンセルと保留を含む全注文の件数"
        type: simple
        agg: count
        expr: order_id
      - name: revenue
        label: "売上"
        description: "completed の注文金額の合計（税抜）"
        type: simple
        agg: sum
        expr: amount
        filter: "{{ Dimension('order__status') }} = 'completed'"
      - name: completed_order_count
        label: "完了注文数"
        description: "completed の注文の件数"
        type: simple
        agg: count
        expr: order_id
        filter: "{{ Dimension('order__status') }} = 'completed'"
      - name: average_order_value
        label: "平均注文単価"
        description: "売上 / 完了注文数"
        type: ratio
        numerator: revenue
        denominator: completed_order_count
```
{% endraw %}

 - 条件付きの集計は `filter` で書き、`{% raw %}{{ Dimension('order__status') }}{% endraw %}` の `order` は entity 名、`status` は dimension 名
 - 1つの mart で完結する指標はモデルの `metrics` に、複数の mart にまたがる指標はトップレベルの `metrics` に書く
 - 旧書式から移行するときは `dbt-autofix deprecations --semantic-layer` で書き換え、差分を確かめる

#### dbt 1.11 以前（旧書式）

旧書式は 1.12 以降でも動くので、移行を急ぐ必要はない

```yaml
semantic_models:
  - name: fct_orders
    model: ref('fct_orders')
    defaults:
      agg_time_dimension: ordered_at
    entities:
      - name: order
        type: primary
        expr: order_id
      - name: customer
        type: foreign
        expr: customer_id
    dimensions:
      - name: ordered_at
        type: time
        type_params:
          time_granularity: day
      - name: status
        type: categorical
    measures:
      - name: order_count
        agg: count
        expr: order_id
      - name: revenue
        agg: sum
        expr: "case when status = 'completed' then amount end"

metrics:
  - name: order_count
    label: "注文数"
    type: simple
    type_params:
      measure: order_count
  - name: revenue
    label: "売上"
    type: simple
    type_params:
      measure: revenue
```

 - measures だけでは `mf query` で問い合わせられないので、measure ごとに simple metric を定義する

### 5. 定番の問いを saved query にする

週次レポートなど問い方が決まっているものは、saved query として登録しておくと LLM が同じ定義で再現できる

```yaml
saved_queries:
  - name: monthly_revenue_by_region
    description: "地域別の月次売上"
    query_params:
      metrics:
        - revenue
      group_by:
        - TimeDimension('metric_time', 'month')
        - Dimension('customer__region')
```

 - `mf query --saved-query monthly_revenue_by_region` で実行できる
 - 人が確かめた「正しい問い方」を持たせると、LLM が定義を取り違えにくくなる

### 6. 定義を検証する

```bash
dbt parse
mf validate-configs
mf list metrics
mf list dimensions --metrics revenue
mf query --metrics revenue --group-by metric_time__month,customer__region --explain
mf query --metrics revenue,order_count --group-by metric_time__month --order metric_time__month
```

 - `mf` は `dbt parse` の出力（`target/`）を読むので、YAML を変えたら先に `dbt parse` を実行する
 - `mf validate-configs` は BigQuery に検証用のクエリを投げるので、定義だけを確かめるなら `--skip-dw` を付ける
 - `--explain` を付けると、クエリを実行せずに MetricFlow が生成した SQL を表示する
 - group by に指定する名前は `<entity>__<dimension>` の形（例 `customer__region`）で、時間は `metric_time__month` のように粒度を付ける
 - 並び替えのオプションは `--order`（dbt のドキュメントには `--order-by` と書かれているが、mf 0.15.0 ではエラーになった）

### 7. mart_meta.json を生成する

`manifest.json` と `catalog.json` から、LLM に必要な情報だけを1つの JSON にまとめる

入れる情報

 - `table`: BigQuery のフル修飾テーブル名（`alias` を反映した `relation_name` から取る）
 - `columns`: 列の型（`catalog.json`）と description（`manifest.json`）
 - `meta`: `config.meta` の全体
 - `semantic`: entities、dimensions、旧書式の measures
 - `metrics`: 指標の定義と、依存する mart
 - `saved_queries`: 登録した定番の問い

入れない情報

 - `approved_for_ai: true` でないモデル（staging や utilities を含む）と、外部パッケージのモデル
 - 承認されていない mart に依存する指標
 - `depends_on` や `fqn` などの dbt 内部の情報

```python
# .claude/skills/analyzing-dbt-marts/scripts/build_mart_meta.py
"""manifest.json と catalog.json から LLM 向けの mart_meta.json を作る"""
import argparse
import json
import sys
from pathlib import Path

REQUIRED_META = ["grain", "join_keys", "pii"]


def compact(value, drop_false=False):
    """None や空の値を落として、LLM に渡す量を減らす"""
    if isinstance(value, dict):
        items = {k: compact(v, drop_false) for k, v in value.items()}
        return {k: v for k, v in items.items()
                if v not in (None, "", [], {}) and not (drop_false and v is False)}
    if isinstance(value, list):
        return [compact(v, drop_false) for v in value]
    return value


def where_filters(value):
    return [f["where_sql_template"] for f in (value or {}).get("where_filters", [])]


def build(target_dir):
    manifest = json.loads((target_dir / "manifest.json").read_text())
    catalog_path = target_dir / "catalog.json"
    catalog = json.loads(catalog_path.read_text()) if catalog_path.exists() else {"nodes": {}}
    project = manifest["metadata"]["project_name"]
    models = {uid: n for uid, n in manifest["nodes"].items() if n["resource_type"] == "model"}

    # セマンティックモデルを元の dbt モデルに対応づける
    semantic_to_model, semantic = {}, {}
    for sm_id, sm in manifest.get("semantic_models", {}).items():
        model_id = sm["depends_on"]["nodes"][0]
        semantic_to_model[sm_id] = model_id
        semantic[model_id] = compact({
            "agg_time_dimension": (sm.get("defaults") or {}).get("agg_time_dimension"),
            "entities": [{"name": e["name"], "type": e["type"], "column": e.get("expr") or e["name"]}
                         for e in sm["entities"]],
            "dimensions": [{"name": d["name"], "type": d["type"], "column": d.get("expr") or d["name"],
                            "granularity": (d.get("type_params") or {}).get("time_granularity")}
                           for d in sm["dimensions"]],
            # 旧書式のみ（新しい書式では空になり、集計の定義は metrics に入る）
            "measures": [{"name": m["name"], "agg": m["agg"], "expr": m.get("expr")}
                         for m in sm["measures"]],
        })

    marts, errors = {}, []
    for uid, node in sorted(models.items(), key=lambda item: item[1]["name"]):
        meta = node["config"].get("meta") or {}
        if node["package_name"] != project or meta.get("approved_for_ai") is not True:
            continue
        missing = [key for key in REQUIRED_META if meta.get(key) in (None, "", [])]
        if missing:
            errors.append(f"{node['name']}: config.meta に {', '.join(missing)} がない")
        # 列の型は catalog.json にしかないので、列名の大文字小文字を無視して YAML と突き合わせる
        docs = {name.lower(): col for name, col in node["columns"].items()}
        columns = {}
        catalog_columns = catalog["nodes"].get(uid, {}).get("columns", {})
        for name, col in sorted(catalog_columns.items(), key=lambda item: item[1]["index"]):
            doc = docs.pop(name.lower(), {})
            columns[name] = compact({"type": col["type"], "description": doc.get("description"),
                                     "meta": doc.get("meta")})
        for doc in docs.values():  # catalog にない列は YAML の data_type を使う
            columns[doc["name"]] = compact({"type": doc.get("data_type"),
                                            "description": doc.get("description"), "meta": doc.get("meta")})
        relation = node.get("relation_name") or f"{node['database']}.{node['schema']}.{node['alias']}"
        marts[node["name"]] = compact({
            "table": relation.replace("`", "").replace('"', ""),  # alias を反映した実テーブル名
            "description": node.get("description"),
            "meta": meta,
            "columns": columns,
            "semantic": semantic.get(uid),
        })

    def metric_marts(metric_id, seen=()):
        found = set()
        for dep in manifest["metrics"][metric_id]["depends_on"]["nodes"]:
            if dep in semantic_to_model:
                found.add(models[semantic_to_model[dep]]["name"])
            elif dep in manifest["metrics"] and dep not in seen:
                found |= metric_marts(dep, seen + (metric_id,))
        return found

    metrics = []
    for metric_id, metric in sorted(manifest.get("metrics", {}).items(), key=lambda item: item[1]["name"]):
        used = sorted(metric_marts(metric_id))
        if not used or any(name not in marts for name in used):
            continue  # 承認されていない mart に依存する指標は渡さない
        metrics.append(compact({
            "name": metric["name"], "label": metric.get("label"),
            "description": metric.get("description"), "type": metric["type"], "marts": used,
            "filter": where_filters(metric.get("filter")),
            "definition": compact(metric.get("type_params"), drop_false=True),
        }))

    names = {m["name"] for m in metrics}
    saved_queries = []
    for sq in sorted(manifest.get("saved_queries", {}).values(), key=lambda s: s["name"]):
        params = sq["query_params"]
        if set(params["metrics"]) <= names:
            saved_queries.append(compact({
                "name": sq["name"], "description": sq.get("description"), "metrics": params["metrics"],
                "group_by": params.get("group_by"), "where": where_filters(params.get("where")),
            }))

    return {"marts": marts, "metrics": metrics, "saved_queries": saved_queries}, errors


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--target-dir", type=Path, default=Path("target"))
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--check", action="store_true", help="既存のファイルが最新かだけを確かめる")
    args = parser.parse_args()

    result, errors = build(args.target_dir)
    if errors:
        sys.exit("\n".join(errors))
    text = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.check:
        if not args.output.exists() or args.output.read_text() != text:
            sys.exit(f"{args.output} が古いので再生成する")
        return
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(text)


if __name__ == "__main__":
    main()
```

実行例

```bash
cd dbt/analytics
dbt docs generate
python ../../.claude/skills/analyzing-dbt-marts/scripts/build_mart_meta.py \
  --target-dir target \
  --output ../../.claude/skills/analyzing-dbt-marts/references/mart_meta.json
```

 - 承認済みの mart に `grain`、`join_keys`、`pii` がなければ、エラーで止まる
 - 新しい書式では manifest の `measures` が空になり、集計の定義は指標の `metric_aggregation_params` に入る
 - 旧書式では指標が `type_params.measure` で measure を参照する
 - 列の型は `manifest.json` には入らず（YAML の `data_type` を除く）、`catalog.json` にしかない
 - `catalog.json` は `dbt docs generate` が BigQuery に問い合わせて作る
 - dbt v2 では `dbt docs generate` が `catalog.json` を出力しないので、`dbt build --write-catalog` などで出す

### 8. Skill を作る

`.claude/skills/analyzing-dbt-marts/SKILL.md`

```markdown
---
name: analyzing-dbt-marts
description: このdbtプロジェクトのBigQueryデータについて、売上・件数・推移・内訳などのビジネス上の質問に答えるときに使う（MetricFlowの指標を優先し、指標で答えられないときだけmartに対してSQLを書く）
---

## 参照するもの
 - mart と指標の定義: references/mart_meta.json（生成物なので編集しない）
 - 業務用語の定義: references/glossary.md
 - dbt プロジェクト: dbt/analytics（mf はここで実行する）

## 手順
 1. 期間、指標の定義、集計の単位があいまいなら、SQL を書く前にユーザに確かめる
    - 用語が指標の description にも glossary.md にもなければ、定義を推測しない
 2. 指標で答えられるか確かめる
    - mart_meta.json の metrics と saved_queries から該当するものを探す
    - 該当すれば `mf query --metrics <指標> --group-by <切り口> --explain` で SQL を確かめ、`--explain` を外して実行する
    - 指標はあるが切り口や条件が足りないときは、`--explain` の SQL を土台にして書き換える
    - dbt の YAML が変わっていれば、先に `dbt parse` を実行する
 3. 指標で答えられないときだけ、mart_meta.json の marts からテーブルを選んで SQL を書く
    - `table` のフル修飾名だけを使い、staging や raw のテーブルは使わない
    - `grain` に合わせて COUNT と COUNT DISTINCT を使い分ける
    - JOIN は `join_keys` と `semantic.entities` のキーだけで行う
    - `forbidden_uses` に書かれた使い方をしない
    - 列の意味は description で確かめ、列名から推測しない
 4. BigQuery で実行する前に処理量を確かめる
    - `bq query --use_legacy_sql=false --dry_run '<SQL>'` で処理バイト数を見る
    - 実行は `bq query --use_legacy_sql=false --maximum_bytes_billed=10000000000 '<SQL>'` で行う
    - パーティション列で期間を絞り、`SELECT *` を使わない
 5. 回答には、結果、実行した SQL または mf コマンド、置いた前提（期間、除外条件など）を含める

## 禁止事項
 - mart_meta.json にないテーブルを使わない
 - PII の列の値をそのまま回答に出さない
 - INSERT、UPDATE、DELETE、CREATE などの書き込みを実行しない
 - 指標で答えられるか確かめずに SQL を書かない
 - ツールやクエリが失敗したら、推測で数値を作らずに失敗を報告する

## メタ情報の改善
 - メタ情報の不足や誤りに気づいたら、回答の最後に、どのモデルのどの項目をどう直すかを提案する
 - mart_meta.json は直接編集せず、dbt の YAML を直してから再生成する
```

 - SKILL.md には手順と禁止事項だけを書いて短く保ち、mart の詳細は `references/` に置いて必要なときに読ませる（Claude Code のドキュメントは SKILL.md を500行以内にするよう勧めている）
 - Claude は `description` を見て Skill を使うか判断するので、どんな質問のときに使うかを具体的に書く
 - mart が増えて `mart_meta.json` が大きくなったら、mart ごとのファイルに分けて、SKILL.md からは一覧だけを参照させる
 - `glossary.md` には、指標にできない業務用語（「アクティブ」の定義など）を人が書く（最初は空でもよい）
 - `bq` コマンドの使い方は[bigquery cli記事](/bigquery-cli/)を参照

### 9. CLAUDE.md から Skill を指す

```markdown
## データ分析
 - データに関する質問には `analyzing-dbt-marts` スキルを使う
 - dbt のモデルや YAML を変更したら、同じ変更の中で `mart_meta.json` を再生成し、SKILL.md も見直す
```

 - Skill は `description` から自動で選ばれるが、CLAUDE.md で名前を指定しておくと確実に使われる
 - dbt 公式の Agent Skills など、ほかの分析用 Skill も入れている場合は、どれを優先するかをここに書く

### 10. 権限とコストを絞る

 - LLM が使う認証情報は読み取り専用にし、mart のデータセットに `roles/bigquery.dataViewer`、クエリを実行するプロジェクトに `roles/bigquery.jobUser` を付ける
 - 個人の権限ではなく専用のサービスアカウントを使う（[サービスアカウントの借用記事](/gcp-service-account-impersonation/)を参照）
 - PII は `pii` に書くだけでなく、authorized view や policy tag で列ごと見えなくする
 - 1クエリあたりの上限は `--maximum_bytes_billed` で、1日あたりの上限は BigQuery のカスタムクォータで掛ける

### 11. Skill を評価する

 - 既存のダッシュボードや定例レポートから、答えが分かっている質問を5〜10問用意する
 - 指標で答えられる質問と、mart に SQL を書く必要がある質問の両方を入れる
 - 新しいセッションで、Skill ありとなしの両方で試して結果を比べる
   - 作業中の文脈が残っていると、Skill の書き漏れに気づけない
 - 数値が合っているかに加えて、使った指標とテーブルが意図どおりかも確かめる
 - 間違えた質問は、プロンプトではなくメタ情報か指標の定義を直してから試し直す

### 12. 運用する

```bash
cd dbt/analytics
dbt docs generate
python ../../.claude/skills/analyzing-dbt-marts/scripts/build_mart_meta.py \
  --target-dir target \
  --output ../../.claude/skills/analyzing-dbt-marts/references/mart_meta.json \
  --check
```

 - モデルや YAML を変えたら `mart_meta.json` を再生成し、同じコミットに含める
 - `--check` で再生成の漏れを検出できる（CI で使う場合は、`dbt docs generate` に BigQuery の読み取り権限が必要）
 - `mart_meta.json` を git で管理しておくと、新しいセッションで dbt を実行しなくてもすぐに読める
 - Anthropic の事例では、保守を止めると精度が1か月で約95%から約65%に落ちた
 - この事例では、データモデルの変更と Skill の更新を同じ PR にまとめる運用で防いでいる

## エージェントに作らせるときの指示

この記事を dbt プロジェクトのエージェントに読ませて Skill を作らせるときの進め方と分担

**進め方**

 1. dbt の版、既存の mart、テスト、description を調べる
 2. `config.meta`、セマンティックモデル、指標、time spine を下書きし、`TODO` の項目と確認してほしい点の一覧を人に渡す
 3. 人が確認して `approved_for_ai: true` にした mart で `mart_meta.json` を生成する
 4. SKILL.md と CLAUDE.md を書き、評価用の質問で試した結果を報告する

**エージェントが決めてよいこと**

 - dbt の版に合わせた書式（1.12 以上なら新しい書式）
 - ファイルの置き場所と、スクリプトの実装
 - SQL、テスト、既存の description から確実に読み取れる entity、dimension、`join_keys`

**人が決めること**

 - `grain`、`forbidden_uses`、`pii` と、指標の定義（売上に何を含めるかなど）
 - どの mart を `approved_for_ai: true` にするか
 - 根拠のない項目は `TODO` のまま残し、推測で埋めない

**完了の条件**

 - `dbt parse` と `mf validate-configs` が通る
 - `mart_meta.json` に承認済みの mart だけが入っている
 - 評価用の質問を新しいセッションで試し、間違えた質問とその原因を報告している

## 判断を誤りやすいポイント

### セマンティック定義を dbt の外に書かない

依存を減らすために、セマンティック定義を dbt の管理外の YAML に書いてスクリプトで直接読む構成は NG

 - dbt と MetricFlow の検証が効かず、typo やスキーマとの不整合に気づけない
 - `manifest.json` に入らないので、MetricFlow や dbt のツールから使えない
 - `mf query` で決まった定義どおりの数値を得る、という一番の利点がなくなる

### 指標を mart の列として焼き込まない

`win_rate` や `total_count` のような集計値を mart の列として物理化するのはアンチパターン

 - 期間や条件で値が変わる（全期間か、直近3か月か）
 - mart の更新タイミングに依存する
 - mart には属性と結合キーだけを持たせ、集計は指標として定義して MetricFlow に計算させる

### 列の型を省略しない

`manifest.json` には列の型が入らない（YAML の `data_type` を除く）ので、`catalog.json` から取る

型が分からないと、LLM は次のような誤りをする

 - STRING の列に算術演算を書く
 - BOOL の列に `= 'true'` と書く（BigQuery では `= true`）
 - TIMESTAMP と DATE を比較して型エラーになる

### 指標の定義を LLM に書かせない

 - LLM が書いた指標の定義は、もっともらしいまま曖昧さが残る
 - エージェントにはコードから読み取れる構造の下書きを任せ、意味（粒度、除外条件、指標の定義）は人が確定する

### 禁止事項をプロンプトだけで守らせない

 - `pii` や `forbidden_uses` は LLM への注意書きであり、強制力はない
 - 見せてはいけない列は、authorized view、policy tag、専用のサービスアカウントの権限で見えなくする

## その後の動向（2026-10 時点）

 - dbt 公式の Agent Skills（2026-02 公開）
   - `answering-natural-language-questions-with-dbt` は「SL に問い合わせる → SL の SQL を手直しする → mart を探して SQL を書く → manifest と catalog を読んで SQL を書く」の順で答え、この記事の Skill と同じ考え方をとる
   - 前の3段は dbt platform（有料）の MCP ツールが前提で、dbt Core だけの環境では最後の段しか動かない
   - この記事の Skill は、前の段を `mf` で補う位置づけ
 - dbt MCP server
   - dbt Core だけで使えるのは CLI 系のツール（`list`、`show`、`compile`、`get_node_details_dev`、`get_lineage_dev` など）
   - 指標の問い合わせ（`query_metrics`）や mart の一覧（`get_mart_models`）には dbt platform が必要
 - dbt v2（旧 Fusion、2026-09 GA）
   - `dbt docs generate` が `catalog.json` を既定で出力しないので、`--write-catalog` を使う
   - プロジェクトのメタデータを SQL で引ける Information Schema が入り、生成スクリプトの代わりになりうる
 - Apache Ossie（旧 Open Semantic Interchange）
   - dbt 1.12 は `dbt parse` のときに `target/osi_document.json` も出力する
   - ベンダー中立の形式で、セマンティック定義をほかのツールと共有できる
 - Google Cloud の Knowledge Catalog（旧 Dataplex Universal Catalog）
   - dbt の `manifest.json` などを取り込めるようになった（2026-09 GA）
   - MetricFlow のセマンティックモデル、指標、saved query も取り込まれる
   - `lookupContext`（Preview）は、スキーマ、説明、クエリログから見た結合などをまとめてエージェントに返す
   - Google が管理する `mart_meta.json` に近い
   - `config.meta` の独自のキー（`grain` など）が取り込まれるかは、ドキュメントに書かれていない
 - Data Agent Kit（2026-10 GA）
   - BigQuery や Knowledge Catalog の MCP とスキルをまとめた無料のプラグインで、Claude Code でも使える
   - `claude plugin install data-agent-kit-starter-pack@claude-plugins-official` で入れられる

## 参考
 - [Migrate to the latest YAML spec - dbt Docs](https://docs.getdbt.com/docs/build/latest-metrics-spec)
 - [MetricFlow time spine - dbt Docs](https://docs.getdbt.com/docs/build/metricflow-time-spine)
 - [MetricFlow commands - dbt Docs](https://docs.getdbt.com/docs/build/metricflow-commands)
 - [Semantic manifest - dbt Docs](https://docs.getdbt.com/reference/artifacts/sl-manifest)
 - [About dbt docs commands - dbt Docs](https://docs.getdbt.com/reference/commands/cmd-docs)
 - [Semantic Layer vs. Text-to-SQL: 2026 Benchmark Update - dbt Developer Blog](https://docs.getdbt.com/blog/semantic-layer-vs-text-to-sql-2026)
 - [dbt-labs/dbt-agent-skills - GitHub](https://github.com/dbt-labs/dbt-agent-skills)
 - [Set up the local dbt MCP server - dbt Docs](https://docs.getdbt.com/docs/dbt-ai/setup-local-mcp)
 - [How Anthropic enables self-service data analytics with Claude](https://claude.com/blog/how-anthropic-enables-self-service-data-analytics-with-claude)
 - [We removed 80% of our agent's tools - Vercel](https://vercel.com/blog/we-removed-80-percent-of-our-agents-tools)
 - [Extend Claude with skills - Claude Code Docs](https://code.claude.com/docs/en/skills)
 - [Import dbt metadata - Knowledge Catalog](https://docs.cloud.google.com/knowledge-catalog/docs/dbt-transfer)
 - [Retrieve data context - Knowledge Catalog](https://docs.cloud.google.com/knowledge-catalog/docs/retrieve-data-context)
 - [Data Agent Kit is now GA - Google Cloud Blog](https://cloud.google.com/blog/topics/developers-practitioners/data-agent-kit-is-now-ga-bring-google-data-cloud-to-any-coding-agent)
