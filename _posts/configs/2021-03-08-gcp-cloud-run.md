---
layout: post
title: "cloud run"
date: 2021-03-08
excerpt: "cloud runついて"
tags: ["gcp", "cloud run"]
config: true
comments: false
---

# cloud runついて

## 概要
 - dockerのコンテナをデプロイして最小限の構成で動作させられるもの
 - cloud functionより高級でkubernetesより低級
 - 一回あたりの実行コストがとても安い
 - 分散性能が高く、大量に並列に実行することに向いている
 - コンテナの実行ユーザが`root`ではない別の権限で動くことになる
   - PosixPathの`~`や環境変数の`$HOME`, `$USER`などは正常に動作しなくなるので、非依存にする必要がある

## 公式ドキュメント
 - [docs](https://cloud.google.com/run/docs)

## 動かすのに必要な権限
 - cloud run admin
 - cloud logging admin
   - デプロイ・起動に関係ないように見えるが、この権限がないと起動することができない
 - cloud storage作成・書き込み権限(コンテナレジストリが依存)

## dockerのコンテナの配置先
 - `gcr.io`
   - `dockerhub.io`は利用できない

## コンテナイメージのデプロイ
 - web uiからできる
 - テンポラリなURLが与えられる

### CUIからデプロイ

**リソースを指定しない場合**  
```console
$ gcloud run deploy <my-api> --image=gcr.io/<my-project>/name
```

**リソースを指定する場合**  
```console
$ gcloud run deploy <my-api> --image=gcr.io/<my-project>/name \
            --cpu=2 \
            --max-instances=2 \
            --memory=8G \
            --min-instances=0 \
            --timeout=300 \
            --port=5050
```
 - [参考](https://cloud.google.com/sdk/gcloud/reference/run/deploy)

## ポートは環境変数で渡さるほうが良い
 - `$PORT`で公開ポートが指定できるほうが良いとされている
 - 例えば、`PORT=5050`と設定したとしても、cloud run環境では必ずhttpsのデフォルトポート`443`にリダイレクトされる

## gitからの継続デプロイ
 - 別サービスの`cloud build`と連携する
   - 特定のgithub等のレポジトリの特定のブランチが更新されたらDockerfileを用いてbuild & pushするということができる

## カスタムドメインのマッピング
 - `cloud run` -> `カスタムドメインを管理`

## アクセス制限
 - IAMでアクセスを限定することができる
   - httpsのheaderにIAMの秘密鍵から一時的な鍵を生成して認証に用いるという方式
 - IP制限
   - できない(ロードバランサを挟むとできる)
 - よくあるヒューリスティック
   - アクセス制限のセキュリティをなくして`X-Api-Key`で認証する

### IAMでのアクセス制限の具体例

**curlでアクセスする場合**  
```console
$ curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" https://*****.run.app
```

**requestsを用いる場合**  
```python
TOKEN = os.popen("gcloud auth print-identity-token").read().strip()
headers = {"x-api-key": "this is for ds-ws.", "Authorization": f"Bearer {TOKEN}"}
params = {"hoo": "bar"}

with requests.post(URL, json=params, headers=headers) as r:
    print(r.text) # 結果を得る
```

 - 参考
   - [デベロッパーの認証/GoogleCloud](https://cloud.google.com/run/docs/authenticating/developers)

