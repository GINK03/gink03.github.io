---
layout: post
title: "GitHub Actions"
date: 2025-12-31
excerpt: "GitHub Actionsの基本"
project: false
config: true
tag: ["github", "actions", "github actions", "ci/cd"]
comments: false
sort_key: "2025-12-31"
update_dates: ["2025-12-31"]
---

# GitHub Actionsの基本

## 概要
 - リポジトリ上のイベント（push や pull_request など）をきっかけに、定義済みの処理を自動実行する仕組み
 - ワークフローは通常 `.github/workflows/*.yml` に置く
 - YAMLのトップレベルはだいたい `name`（表示名）／`on`（トリガー）／`jobs`（実行内容）で構成され、`jobs` の中に複数のジョブを定義
   - `jobs` はデフォルトで並列実行
 - `permissions` を明示して最小権限で実行すると意図しない書き込みを防げる

## 最小のワークフロー
 - 「PRが来たらテスト相当のコマンドを実行する」

```yaml
name: PR Check
on:
  pull_request:

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run tests
        run: |
          echo "Run something here"
```

## 最小権限で動かす例
 - tokenでの書き込みを不要にする場合は明示的に`permissions`を設定する

```yaml
name: PR Check
on:
  pull_request:

permissions:
  contents: read

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo "run tests"
```

## jobsの依存を定義
 - `needs` キーワードで依存関係を定義可能

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - run: echo "test..."

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - run: echo "deploy..."
```

## 条件付きで動かす（`if:` ）
 - 「mainブランチのpushのときだけデプロイしたい」

```yaml
jobs:
  deploy:
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    runs-on: ubuntu-latest
    steps:
      - run: echo "deploy on main push only"
```

## ジョブ間で情報を受け渡しする方法
 - ステップ内で `GITHUB_OUTPUT` に書き、ジョブの `outputs:` として外に出し、次ジョブが `needs.<job_id>.outputs.<name>`

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    outputs:
      package_version: ${{ steps.meta.outputs.version }}
    steps:
      - id: meta
        run: echo "version=1.2.3" >> "$GITHUB_OUTPUT"

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploy version=${{ needs.build.outputs.package_version }}"
```
