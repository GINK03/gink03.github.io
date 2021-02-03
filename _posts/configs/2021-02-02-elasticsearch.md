---
layout: post
title: "elasticsearch"
date: 2021-02-02
excerpt: "elasticsearchの使い方"
project: false
config: true
tag: ["elasticsearch"]
comments: false
---

# elasticsearchの使い方

## インストールと開始
 - インストールバイナリをダウンロードしてインストールする
   - [link](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html)

*ubuntuの場合*
```console
# elasticsearchをインストールする
$ wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.2-amd64.deb
$ sudo apt install ./elasticsearch-7.10.2-amd64.deb
$ sudo systemctl start elasticsearch
$ sudo systemctl enable elasticsearch
# kibanaをインストールする
$ wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
$ sudo apt-get install apt-transport-https
$ echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
$ sudo apt-get update && sudo apt-get install kibana
```

## リモートアクセスを許可
 - githubのissueに解決策がある
   - [link](https://github.com/elastic/elasticsearch/issues/19987)

`/etc/elasticsearch/elasticsearch.yml`を開いて以下を追記して`elasticsearch`を再起動する
```yaml
transport.host: localhost
transport.tcp.port: 9300
http.port: 9200
network.host: 0.0.0.0
```

同様に、`kibana`について`/etc/kibana/kibana.yml`を開いて以下を追記して`kibana`を再起動する
```yaml
server.host: "0.0.0.0"
```

## `elasticsearch`のバイナリのパス
 - `/usr/share/elasticsearch/bin`

## elasticsearchの日本語解析の登録について
 - 参考
   - [link](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-kuromoji.html)
```console
# /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-kuromoji
# /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-icu
# systemctl restart elasticsearch
```

## 具体的な使い方について
 - qiitaにサンプルクエリがある
   - [link](https://qiita.com/nskydiving/items/1c2dc4e0b9c98d164329)

## 具体的なtfidf等のアルゴリズムのminimal example
 - 公式
   - [link](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-modules-similarity.html)

## 日本語で検索する
 - 公式: how-to-implement-japanese-full-text-search-in-elasticsearch
   - [link](https://www.elastic.co/jp/blog/how-to-implement-japanese-full-text-search-in-elasticsearch)

 - 実際にtwitterのコーパスで試しにindexを構築した例
   - [gist](https://gist.github.com/GINK03/c366a6492d0f3aa174a30265d918c2e4)
