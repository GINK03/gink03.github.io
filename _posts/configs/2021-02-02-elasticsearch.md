---
layout: post
title: "elasticsearch"
date: 2021-02-02
excerpt: "elasticsearchの使い方"
project: false
config: true
tag: ["elasticsearch"]
comments: false
sort_key: "2021-02-17"
update_dates: ["2021-02-17","2021-02-05","2021-02-03","2021-02-03"]
---

# elasticsearchの使い方

## インストールと開始
 - インストールバイナリをダウンロードしてインストールする
   - [link](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html)

*ubuntuの場合(バージョンは適宜変更)*
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

## REST構造について

```
/experiment/_doc/n7kMZ3cBe-XfFcbgxeJ6
 ↑ index    ↑ type ↑ id
```

*e.g. index=experimentに新しいレコードを追加する*
```console
data = {'tweet': r.tweet, "username": r.username }
response = requests.post(url, data=json.dumps(data), headers=headers)
response.text

>>> {'_index': 'experiment',
 '_type': '_doc',
 '_id': 'HbqKqncBe-XfFcbgs1qd',
 '_version': 1,
 'result': 'created',
 '_shards': {'total': 2, 'successful': 1, 'failed': 0},
 '_seq_no': 1628302,
 '_primary_term': 1}
```

*e.g. あるid=n7kMZ3cBe-XfFcbgxeJ6の要素を取り出す*
```console
$ GET http://localhost:9200/experiment/_doc/n7kMZ3cBe-XfFcbgxeJ6 | jq
{
  "_index": "experiment",
  "_type": "_doc",
  "_id": "n7kMZ3cBe-XfFcbgxeJ6",
  "_version": 1,
  "_seq_no": 621,
  "_primary_term": 1,
  "found": true,
  "_source": {
    "tweet": "自民党議員のみなさん、いなくなって下さい。",
    "username": "c443dt4roni3ie9"
  }
}
```

*e.g. あるid=n7kMZ3cBe-XfFcbgxeJ6の要素を更新*

```python
headers = {'Content-Type': 'application/json'}
data = {
    "username": "foo",
    "tweet": "bar" 
}
url = 'http://localhost:9200/experiment/_doc/n7kMZ3cBe-XfFcbgxeJ6'
response = requests.put(url, data=json.dumps(data), headers=headers)
search_hits = json.loads(response.text)
search_hits

>>>  {'_index': 'experiment',
   '_type': '_doc',
   '_id': 'nrkMZ3cBe-XfFcbgxeJt',
   '_version': 2,
   'result': 'updated',
   '_shards': {'total': 2, 'successful': 1, 'failed': 0},
   '_seq_no': 30000,
   '_primary_term': 1}
```

*e.g. あるindex=experimentで統計情報を表示*

```console
$ GET http://localhost:9200/experiment/_stats | jq
...
```

## bulkで新規作成または更新
bulk apiだけが少々変わった構造になっている
 - headerが`{'Content-Type': 'application/x-ndjson'}`を期待する
 - `index`の指定データ + `doc`のデータの交互で構築される
 - 改行で終わる

```python
bulk = ""
for i in tqdm_notebook(range(len(df[:30000]))):
    r = df.iloc[i]
    index = json.dumps({"index": {"_id": i}})
    data = {'tweet': r.tweet, "username": r.username }
    bulk += index + '\n' + json.dumps(data, ensure_ascii=True) + '\n'
    
url = 'http://localhost:9200/experiment/_bulk'

response = requests.post(url, data=bulk, headers={'Content-Type': 'application/x-ndjson'})
response.text
```

## 件数を指定して取得

```python
query = {
  "query": {
    "match_all": {}
  },
    "fields": ["_id"],
    "size": 100 # これで100件取得できる、増やしたい場合、増やせば良い
}
url = 'http://localhost:9200/experiment/_doc/_search?scroll=1m'
response = requests.get(url, data=json.dumps(query), headers=headers)
search_hits = json.loads(response.text)['hits']['hits']

for idx, hit in enumerate(search_hits):
    print(idx + 1, hit)
```

## elastic searchでの自然言語の検索について

*BM25というアルゴリズム*  
アルゴリズムが複数存在し、[`BM25`](https://www.elastic.co/jp/blog/practical-bm25-part-2-the-bm25-algorithm-and-its-variables)がelastic searchのイチオシのようである。tf-idfのidfを長さ要素を考慮したもののように見える  

事前に`index`にどのトークナイザを使用するか、どのアルゴリズムでマッチさせるかを指定しておく必要がある  

こちらの[リンク](https://www.elastic.co/jp/blog/how-to-implement-japanese-full-text-search-in-elasticsearch)を精読しないとなかなか習熟することができない   

*形態素結果等を確認する*  

```python
url = 'http://localhost:9200/experiment/_analyze'

data = {'text': "大好き。プリキュア5大好き。", "tokenizer": "kuromoji_tokenizer" }
response = requests.post(url, data=json.dumps(data), headers=headers)
    
json.loads(response.text)

>>> {'tokens': [{'token': '大好き',
   'start_offset': 0,
   'end_offset': 3,
   'type': 'word',
   'position': 0},
  {'token': 'プリキュア',
   'start_offset': 4,
   'end_offset': 9,
   'type': 'word',
   'position': 1},
  {'token': '5',
   'start_offset': 9,
   'end_offset': 10,
   'type': 'word',
   'position': 2},
  {'token': '大好き',
   'start_offset': 10,
   'end_offset': 13,
   'type': 'word',
   'position': 3}]}
```

