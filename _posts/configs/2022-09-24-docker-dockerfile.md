---
layout: post
title: "dockerfilee"
date: 2022-09-24
excerpt: "dockerfileの使い方と書き方"
tags: ["container", "docker", "dockerfile"]
config: true
comments: false
sort_key: "2022-09-24"
update_dates: ["2022-09-24"]
---

# dockerfileの使い方と書き方

## 概要
 - コンテナをビルドするときのファイル
 - Makefileに相当するもの

## 機能の説明

### WORKDIR
 - dockerを実行した時、どのディレクトリから始めるか

### ENTRYPOINT
 - 実行時のコマンド
 - 文字列としてエスケープしたりする必要はない

### CMD
 - 実行時のコマンド
 - 文字列としてエスケープしたりする必要はない
 - `ENTRYPOINT`との違いは、`CMD`は`ENTRYPOINT`の実行後に実行される補助的なものである

**例**  
```dockerfile
CMD gunicorn --bind 0.0.0.0:$PORT --workers=2 bin:app
```

### ARG
 - dockerfile内部に変数を与える
 - ローカル開発と本番で使用する基底イメージが異なる時
 - dockerfile内部で挙動を変えたいときなど

**例**
```dockerfile
ARG BASE_CONTAINER=nvidia-base-container:latest
FROM $BASE_CONTAINER

WORKDIR /
COPY . /app/
RUN pip install -r ./app/requirements.txt
WORKDIR /app
```
 - `BASE_CONTAINER`にデフォルトの値として`nvidia-base-container:latest`を与えている
 - `BASE_CONTAINER`はビルド時に指定することで明示的にオーバーライドできる

**例**
```console
$ docker build . --build-arg BASE_CONTAINER="ubuntu"
```

### 環境変数をdockerfile内部で使う
 - 例えば`$HOME`が必要なときに以下のような記述が可能

```dockerfile
RUN cd /tmp/mecab-ipadic-neologd; ./bin/install-mecab-ipadic-neologd -n -y --prefix $HOME/.lib/mecab-ipadic-neologd;
```

---

## .dockerignoreについて
 - `docker build`時に`sending build context to docker daemon`と出てスタックする場合、非常に大きなディレクトリがプロジェクトの下にあるケースが有る
 - `.dockerignore`を追加して特定のディレクトリをスキップするようにする
 - この設定は`Dockerfile`内部でも有効

**例**
```dockerignore
# Ignore all log files
*.log

# Except this one
!important.log

# Ignore node_modules directory
node_modules/

# Ignore temporary files
*.tmp
*.swp
*.bak

# Ignore git related files
.git/
.gitignore
```

---

## cacheを有効に使いこなす
 - ダウンロードが発生するコマンドはできるだけ早い段階に持ってくる
 - コードの変更が発生する部分は最後に持ってきて、影響を最小限に留める
 - 参考
   - [Docker のキャッシュを全力で使いこなそう](https://zenn.dev/kou64yama/articles/powerful-docker-build-cache)


