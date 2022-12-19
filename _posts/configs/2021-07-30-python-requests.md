---
layout: post
title: "requests"
date: 2021-07-30
excerpt: "requestsの使い方"
project: false
config: true
tag: ["python", "requests"]
comments: false
sort_key: "2022-05-19"
update_dates: ["2022-05-19","2021-10-19","2021-08-02","2021-07-30"]
---

# requestsの使い方
 - pythonのライブラリである
 - http, https経由のコンテンツを取得できる

## UserAgent情報を付加する

```python
import requests

headers = {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.136 Safari/537.36"}
with requests.get(url, headers=headers) as r:
    html = r.text
```

## proxyを使用する
 - socks5がよいらしいが、http, httpsプロトコルも使える
 - この資料ではsocks5で使用した場合を記述する

**インストール**  

```console
$ python3 -m pip install requests[socks]
```

**使用例**  

```python
import requests

with requests.get(url, proxies=dict(http="socks5://user:pass@host:port", https="socks5://user:pass@host:port")) as r:
	html = r.text
```

## 取得したコンテンツの文字コードを推定する

```python
with requests.get(url, headers=headers, proxies=proxies) as r:
	r.encoding = r.apparent_encoding
	html = r.text
```
 - たまに失敗するので明示的に指定できれば確実

## 取得したコンテンツの文字コードを指定する

**sjisに指定する例**  

```python
with requests.get(url, headers=headers, proxies=proxies) as r:
	r.encoding = "sjis"
	html = r.text
```

## タイムアウトを用いる

```python
proxies = {"https://": "http://miiyuane-rotate:wl7v2md2q5o4@" + random.choice(L)}
try:
    with requests.get(url, proxies=proxies, headers=headers, allow_redirects=False, timeout=10.0) as r:
        html = r.text
except requests.exceptions.Timeout as exc:
    print("timeout") # 何か処理を入れる
    return
```

## マルチプロセスでrequestsを動作させるTIPS
 - マルチプロセスのスケジューラかrequestsの動作の不安定さかの影響で、1リクエストに1プロセスを割り当ててしまうとハングアップしてしまう
 - urlのチャンクを作ってチャンクをプロセスに割り当てるというスタイルを取ると安定する

## streamで情報を取得する
 - twitter apiのstream sampleを利用する例

```python
url = "https://api.twitter.com/2/tweets/sample/stream"
bearer_oauth = "..."

r = requests.request("GET", url, auth=bearer_oauth, stream=True)
for line in r.iter_lines():
    if line:
        json_response = json.loads(line)
        print(json.dumps(json_response, indent=4, sort_keys=True))
```

