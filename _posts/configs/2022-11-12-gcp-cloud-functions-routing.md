---
layout: post
title: "gcp cloud functions routing"
date: "2022-11-12"
excerpt: "gcp cloud functionsのroutingの仕方"
config: true
tag: ["gcp", "gcloud", "cloud functions", "routing", "flask"]
comments: false
sort_key: "2022-11-12"
update_dates: ["2022-11-12"]
---

# gcp cloud functionsのroutingの仕方

## 概要
 - cloud functionsのデフォルトの使い方ではroutingはできない
 - cloud functionsで呼び出される関数を設定し、そこからURLパラメータを解析し、適切な関数をディスパッチするという流れになる
   - 通常のサーバを建てるより、一回分の手間が発生する

## Pythonでroutingする場合
 - 特別な依存は必要ない
 - 以下の例では、`main`をcloud functionsの呼び出し関数に設定

```python
from flask import Flask, request

app = Flask("internal")

@app.route('/user_id/<string:id>', methods=['GET', 'POST'])
def user_id(id):
    print(f'user_id = {id}')
    return f'user_id = {id}', 200

@app.route('/team_id/<string:id>', methods=['GET', 'POST'])
def team_id(id):
    print(f'team_id = {id}')
    return f'team_id = {id}', 200

def main(request):
    # Create a new app context for the internal app
    ctx = app.test_request_context(path=request.full_path,
                                   method=request.method)

    # Copy main request data from original request
    # According to your context, parts can be missing. Adapt here!
    ctx.request.data = request.data
    ctx.request.headers = request.headers

    # Activate the context
    ctx.push()

    # Dispatch the request to the internal app and get the result
    return_value = app.full_dispatch_request()

    # Offload the context
    ctx.pop()

    # Return the result of the internal app routing and processing
    return return_value
```

### 動作例

```console
$ curl https://us-central1-starry-lattice-256603.cloudfunctions.net/function-2/user_id/1
user_id = 1
```

```console
$ curl https://us-central1-starry-lattice-256603.cloudfunctions.net/function-2/team_id/1
team_id = 1
```

---

## 参考
 - [Use multiple paths in Cloud Functions, Python and Flask/Google Cloud - Community](https://medium.com/google-cloud/use-multiple-paths-in-cloud-functions-python-and-flask-fc6780e560d3)
 - [Using Flask Routing in GCP Function?/stack overflow](https://stackoverflow.com/questions/53488766/using-flask-routing-in-gcp-function/55576232#55576232)
