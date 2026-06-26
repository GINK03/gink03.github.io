---
layout: post
title: "github actions/workflows"
date: 2023-12-23
excerpt: "github actions/workflowsの使い方"
project: false
config: true
tag: ["github", "workflows", "actions"]
comments: false
sort_key: "2023-12-23"
update_dates: ["2023-12-23"]
---

## 概要
 - github workflows/actionsはgithub上で動作するCI/CDツール
 - `.github/workflows`以下にyamlファイルを配置することで動作する
   - yamlファイルを配置することが有効化のトリガーになる
 - `uses`で指定するアクションは第三者が作成したものを利用することができる
   - 例えば、docker buildを行うアクションを利用することで、docker buildを行うことができる

## 具体例

### Hello World

```yaml
name: hello world
run-name: ${{ github.workflow }} (${{ github.ref_name }})
on:
  - push

jobs:
  build_and_deploy_post_generator:
    name: build post_generator and deploy it to dev
    runs-on:
      - ubuntu-latest
    steps:
      - run: echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."
```

### Docker Build and Push

```yaml
name: Docker Build and Push

on:
  push:
    branches:
      - main

jobs:
  build_and_push:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout Repository
      uses: actions/checkout@v2

    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v1

    - name: Login to Docker Hub
      uses: docker/login-action@v1
      with:
        username: ${{ secrets.DOCKER_HUB_USERNAME }}
        password: ${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}

    - name: Build and Push Docker Image
      uses: docker/build-push-action@v2
      with:
        context: .
        file: ./Dockerfile
        push: true
        tags: yourusername/yourimage:latest
```

### Python Lint

```yaml
name: Python Linting with Ruff

on: [push]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v3

    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.x' # or any specific Python version you need

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

    - name: Install Ruff
      run: pip install ruff

    - name: Run Ruff
      run: ruff check --output-format=github .
      # You can add additional arguments or specify paths as needed
```

## GitHub Enterpriseでの利用
 - `runs-on`で動作させる環境を指定することになる
 - 社内用の認証を設定したactionを利用することで特定のセキュリティ要件を満たすことができる

## 参考
 - GitHub Actionsの書き方についてデバッグ設定、runs-onやcheckoutなどの仕組みや構造も含めて徹底解説](https://qiita.com/shun198/items/14cdba2d8e58ab96cf95)
