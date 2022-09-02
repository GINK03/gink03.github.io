---
layout: post
title: "function framework"
date: "2022-09-02"
excerpt: "function frameworkの使い方"
config: true
tag: ["gcp", "gcloud", "cloud functions", "function-framework", "function_framework"]
comments: false
sort_key: "2022-08-12"
update_dates: ["2022-08-12"]
---

# gcp cloud functionsの使い方

## 概要
 - GCPの[/cloud funcitons/](/gcp-cloud-functions/)のテストフレームワーク
 - 特定の関数を一つだけテストしたいときに便利

## Pythonで使用する場合

```python
from flask import escape
import functions_framework

@functions_framework.http
def hello_http(request):
    request_json = request.get_json(silent=True)
    # getパラメータ
    request_args = request.args
    if request_json and 'name' in request_json:
        name = request_json['name']
    elif request_args and 'name' in request_args:
        name = request_args['name']
    else:
        name = 'World'
    return 'Hello {}!'.format(escape(name))
```

**ローカルで実行**
 
```console
$ functions_framework --target=hello_http
```

**クエリ**
```console
$ curl localhost:8080?name=お餅
Hello お餅!
```
  
## 参考
 - [Function Frameworks を使用した関数の実行](https://cloud.google.com/functions/docs/running/function-frameworks)

