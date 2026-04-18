---
layout: post
title: "dbt セマンティックレイヤー for LLM"
date: 2026-04-06
excerpt: "dbt Coreのセマンティックレイヤーを構築し、LLMが正確なBQクエリを生成できる基盤を作る手順"
project: false
kaggle: true
tag: ["dbt", "MetricFlow", "LLM", "BigQuery", "semantic layer"]
comments: false
sort_key: "2026-04-06"
update_dates: ["2026-04-06"]
---

# dbt セマンティックレイヤー for LLM

## 概要

 - dbt CoreプロジェクトにMetricFlowベースのセマンティックレイヤーを構築し、LLMが自然言語でBigQueryデータを正確に分析できる基盤を作る手順
 - dbtの基本については[dbt記事](/dbt/)を参照

## 背景と目的

LLMにSQLを書かせる際、テーブル名やカラム名だけでは不十分で、以下の情報がないと誤ったクエリが生成される

 - フル修飾テーブル名（`project.dataset.table`）
 - カラムの型（INT64, STRING, BOOL 等）
 - テーブルの粒度（1行が何を意味するか）
 - 安全なJOINキー
 - やってはいけない使い方（forbidden_uses）
 - 集計可能なメジャー（何をcount/sum/avgできるか）

これらをdbtの正式な仕組みで管理し、単一のJSONファイルとしてLLMに渡すのがこの施策の核

## アーキテクチャ

```
_schema.yml (config.meta)          → description, grain, join_keys, forbidden_uses, pii
_semantic_models.yml (MetricFlow)  → entities, dimensions, measures
        ↓
    dbt docs generate
        ↓
manifest.json + catalog.json
        ↓
    show_mart_meta.py
        ↓
mart_meta.json  ← LLMが読むファイル（git管理）
        ↓
CLAUDE.md が「分析前にこれを読め」と指示
```

## 手順

### 1. MetricFlowのインストール

```bash
uv pip install dbt-metricflow
```

 - MetricFlowがないとdbtがセマンティック定義をパースしない
 - 依存追加を避けてstandalone YAMLで代替するのはアンチパターン — dbtのバリデーションが効かず、ただのドキュメントになる

### 2. time spineモデルの作成

MetricFlowは時間軸集計のベースとなるtime spineテーブルを要求する

`models/utilities/metricflow_time_spine.sql`

{% raw %}
```sql
{{ config(materialized='table') }}

select date as date_day
from unnest(
    generate_date_array('2020-01-01', '2030-12-31', interval 1 day)
) as date
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

 - dbt 1.9以降は `time_spine.standard_granularity_column` を `_models.yml` に記載するのが正式な方式
 - `dbt_project.yml` の `time-spines:` セクションによる旧方式は deprecated（`MFTimespineWithoutYamlConfigurationDeprecation`）

### 3. `_schema.yml` に `config.meta` を定義

各martモデルに以下のメタ情報を定義する

```yaml
models:
  - name: your_model
    description: >
      モデルの説明
    config:
      meta:
        approved_for_ai: true
        grain: "1行の意味（例: 1人材1行）"
        business_name: "非技術者向けの名称"
        join_keys: ["pk_column", "fk_column"]
        recommended_filters: ["status", "created_at"]
        forbidden_uses: "やってはいけないこと（任意）"
        pii: "PIIの有無と対処（ハッシュ済み等）"
        owner: "問い合わせ先メールアドレス"
    columns:
      - name: column_name
        description: "カラムの説明"
```

各フィールドの判断基準

| フィールド | 書くべきとき | 書かないべきとき |
|---|---|---|
| `grain` | 必ず書く | - |
| `join_keys` | 必ず書く（PK + 他テーブルとのFK） | - |
| `forbidden_uses` | データ品質に落とし穴がある場合 | 問題がなければ省略 |
| `pii` | PIIが含まれる or マスク済みの場合 | PIIが一切ない場合は `false` |
| `user_facing` | ビジネス職に見せるべきでない場合（`false`） | デフォルトは省略（＝見せてよい） |

 - 確実にわかるものだけ書く
 - 推測で書かない

### 4. `_semantic_models.yml` にセマンティック定義

```yaml
semantic_models:
  - name: your_model
    description: "短い説明"
    model: ref('your_model')
    defaults:
      agg_time_dimension: created_at
    entities:
      - name: entity_name
        type: primary
        expr: column_name
    dimensions:
      - name: column_name
        type: time
        type_params:
          time_granularity: day
      - name: status_column
        type: categorical
    measures:
      - name: record_count
        agg: count
        expr: pk_column
```

設計原則

 - `entities` はJOINの起点。primary（PK）とforeign（FK）を明確に分ける
 - `dimensions` は分析の切り口（WHERE/GROUP BYに使うカラム）
 - `measures` は集計値。条件付きcountは `expr: "case when condition then column end"` で表現
 - 全martにセマンティック定義を書く。一部だけ書くとLLMが未定義のモデルを使えない

entityのtypeの種類

| type | 意味 |
|---|---|
| `primary` | そのモデルのPK |
| `foreign` | 他モデルへの参照キー（FK） |
| `unique` | 一意だがPKではないキー |

### 5. 抽出スクリプトの作成

`manifest.json`（メタ + セマンティック）と `catalog.json`（カラム型）の両方から情報を抽出するPythonスクリプトを作る

必ず含めるべき情報

 - `table`: フル修飾BQテーブル名（`database.schema.name`）→ LLMがFROM句を書ける
 - `columns[].type`: BQデータ型 → 型安全なSQL
 - `columns[].description`: カラムの意味
 - `meta`: config.meta全体
 - `semantic`: entities / dimensions / measures

含めてはいけない情報

 - staging viewやutilityモデル → martだけに絞る
 - manifest.jsonの内部構造（depends_on, fqn等） → LLMに不要なノイズ

```python
# scripts/show_mart_meta.py（参考実装の骨格）
import json

with open("target/manifest.json") as f:
    manifest = json.load(f)

with open("target/catalog.json") as f:
    catalog = json.load(f)

result = {}
for node_id, node in manifest["nodes"].items():
    if node["resource_type"] != "model":
        continue
    meta = node.get("config", {}).get("meta", {})
    if not meta.get("approved_for_ai"):
        continue

    catalog_node = catalog["nodes"].get(node_id, {})
    columns = {}
    for col_name, col_meta in catalog_node.get("columns", {}).items():
        columns[col_name] = {
            "type": col_meta.get("type"),
            "description": node["columns"].get(col_name, {}).get("description", ""),
        }

    result[node["name"]] = {
        "table": f"{node['database']}.{node['schema']}.{node['name']}",
        "description": node.get("description", ""),
        "meta": meta,
        "columns": columns,
    }

with open("mart_meta.json", "w") as f:
    json.dump(result, f, ensure_ascii=False, indent=2)
```

### 6. CLAUDE.mdへの指示記載

```markdown
### マートメタ情報

データ分析を行う前に、必ず `dbt/analytics/mart_meta.json` を読むこと
このファイルには全martモデルの構造が含まれており、
安全で正確なクエリを書くために不可欠な情報源である
```

 - この一文がないと、LLMは `mart_meta.json` の存在を知らない
 - `approved_for_ai: false` のモデルは抽出スクリプト側でフィルタリングすることで、意図しないテーブルをLLMに渡すリスクを減らせる

### 7. 運用フロー

```bash
# モデル定義を変更したら
mise run dbt-docs           # manifest.json + catalog.json を再生成
mise run dbt-meta-json      # mart_meta.json を再生成
git add dbt/analytics/mart_meta.json
git commit                  # mart_meta.json をgit管理に含める
```

 - `mart_meta.json` をgit管理する理由: LLMの新規セッション開始時にdbt docs generateを走らせなくても即参照できるため

## 判断を誤りやすいポイント

### MetricFlowの依存を避けてstandalone YAMLで代替しない

依存を避ける目的でセマンティック定義をdbt管理外のYAMLに書き、スクリプトで直接読む構成はNG

 - dbtのバリデーションが効かない（typoやスキーマ不整合に気づけない）
 - manifest.jsonに出力されない（dbtエコシステムとの統合が切れる）
 - 「dbtのセマンティックレイヤーを使っている」とは言えない状態になる

本質は「LLMが正確に分析できること」であり、そのためにセマンティック情報がdbtの正式パイプラインで管理されていることが重要

### 集計値（measure）をmartテーブルに焼き込まない

`win_rate` や `total_count` のようなmeasureをmartのカラムとして物理化するのはアンチパターン

 - 期間や条件で値が変わる（いつの集計か？全期間か？直近3ヶ月か？）
 - martのリフレッシュタイミングに依存する
 - 分析時にJOINして動的に算出する方が正確

martにはdimension（属性）とFK（結合キー）だけを持たせ、measureはセマンティック定義で「何を集計できるか」を宣言するにとどめる

### カラム型情報を省略しない

`manifest.json` にはカラム型が含まれない（descriptionのみ）。`catalog.json` から取得する必要がある

型情報がないとLLMは

 - STRING型カラムに算術演算を書く
 - BOOL型カラムに `= 'true'` と書く（BQでは `= true`）
 - TIMESTAMP型の比較で型不一致エラーを起こす

`dbt docs generate` はmanifestとcatalogの両方を出力するため、両方から情報を取ること

## ファイル構成

```
dbt/analytics/
  dbt_project.yml
  mart_meta.json                           # LLM向け統合ファイル（git管理）
  models/
    marts/
      _schema.yml                          # description + config.meta
      _semantic_models.yml                 # MetricFlowセマンティック定義
      *.sql
    staging/
      _sources*.yml
      stg_*.sql
    utilities/
      metricflow_time_spine.sql
      _models.yml                          # time_spine.standard_granularity_column を記載
scripts/
  show_mart_meta.py                        # manifest + catalog → mart_meta.json
```
