---
layout: post
title: "docker compose"
date: 2026-01-25
excerpt: "docker composeの使い方"
config: true
tag: ["container", "docker", "compose"]
comments: false
sort_key: "2026-01-25"
update_dates: ["2026-01-25"]
---

# docker compose

## 概要
 - Docker Compose v2の使い方をまとめる
 - 実行は `docker compose` を使う
 - 既定のファイル名は `compose.yaml`

## Debianへのインストール
 - Dockerが入っていれば `docker compose` は不要なことが多い
 - まずは次で確認する

```bash
$ docker compose version
```

 - 無い場合はプラグインを追加する

```bash
$ sudo apt update
$ sudo apt install docker-compose-plugin
$ docker compose version
```

## 最小のcompose.yaml

```yaml
services:
  app:
    image: nginx:alpine
    ports:
      - "8080:80"
```

## 起動と停止

```bash
# 起動
$ docker compose up

# バックグラウンド起動
$ docker compose up -d

# ビルドして起動
$ docker compose up --build

# 停止と削除
$ docker compose down
```

## よく使うコマンド

```bash
# コンテナ一覧
$ docker compose ps

# ログの追従
$ docker compose logs -f

# 再ビルドして起動
$ docker compose up -d --build

# イメージ取得
$ docker compose pull

# シェルに入る
$ docker compose exec app sh

# debugでbashに入る
$ docker compose exec -it app bash

# 一度だけコマンドを実行
$ docker compose run --rm app echo hello
```

## 環境変数と.env
 - 変数は `compose.yaml` 内で展開できる
 - ルートに `.env` を置くと自動で読み込まれる

```yaml
services:
  app:
    image: "${APP_IMAGE}"
    environment:
      - TZ=Asia/Tokyo
    env_file:
      - .env.local
```

## 複数ファイル
 - 環境ごとに上書きする時に便利

```bash
$ docker compose -f compose.yaml -f compose.prod.yaml up -d
```

## profiles
 - 起動対象を切り替える

```yaml
services:
  db:
    image: postgres:16
    profiles: ["dev"]
```

```bash
$ docker compose --profile dev up -d
```

## depends_on と healthcheck
 - 起動順の管理は `depends_on` を使う
 - サービスの準備待ちは `healthcheck` と組み合わせる

```yaml
services:
  api:
    image: ghcr.io/example/api:latest
    depends_on:
      db:
        condition: service_healthy
  db:
    image: postgres:16
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 3s
      retries: 10
```

## 設定の確認

```bash
# 展開後の設定を確認
$ docker compose config

# 起動中のプロジェクト一覧
$ docker compose ls
```
