---
layout: post
title: "GCP Cloud Run custom domain mapping"
date: 2026-07-19
excerpt: "Cloud Runへカスタムドメインを割り当てる方法"
config: true
tag: ["GCP", "cloud run", "dns", "custom domain"]
comments: false
sort_key: "2026-07-19"
update_dates: ["2026-07-19"]
---

## 概要

 - Cloud Runの`.run.app` URLへ独自ドメインを割り当てる機能
 - `dashboard.example.com`のようなURLを保ったままCloud Runサービスへアクセスできる
 - HTTPリダイレクトではなく、DNS、TLS、Cloud Runのルーティングを組み合わせる
 - `cross domain mapping`はCloud Runの正式な機能名ではなく、正式名称は`custom domain mapping`
 - 2026-07-19時点で直接domain mappingはLimited availabilityかつPreview
 - Googleは本番サービスにGlobal external Application Load Balancerを推奨
 - Cloud Run自体は[Cloud Run記事](/gcp-cloud-run/)、DNSの基本は[DNS記事](/dns/)を参照

### Route 53で取得したドメインを使う例

Route 53で`example.com`を取得し、Cloud Runのサービスを`dashboard.example.com`で公開するケース

```text
Route 53 domain registration
  |
  v
Route 53 Public Hosted Zone
  |-- TXT   google-site-verification
  |-- CNAME dashboard -> Google指定値
  v
Googleのフロントエンド
  |
  v
Cloud Run service
```

Route 53でドメインを登録すると、通常は同名のPublic Hosted Zoneと4つのName Serverが自動作成される

この場合はCloud DNSへ移管せず、Cloud Runが返した`resourceRecords`をRoute 53のHosted Zoneへ追加すればよい

サブドメインがCNAMEとして返された場合の入力例

| Route 53の項目 | 設定例 |
|---|---|
| Record name | `dashboard.example.com` |
| Record type | `CNAME` |
| Value | `ghs.googlehosted.com.` |
| Alias | Off |
| Routing policy | Simple |

 - ドメイン所有権確認用のTXTレコードも同じHosted Zoneへ追加する
 - Google CloudとAWSのアカウントを連携する必要はない
 - Route 53はドメイン登録と権威DNSを担当し、Cloud RunはHTTPSの終端とサービスへのルーティングを担当する
 - CNAMEの値を固定せず、`resourceRecords`に表示された値を使う
 - ルートドメインでAまたはAAAAが返された場合も、そのレコード種別と値をそのまま登録する
 - Googleの宛先をRoute 53 Aliasレコードへ置き換えない

Route 53のHosted Zoneが実際に権威DNSか確認する

```console
$ dig +short NS example.com
```

表示されたName ServerがHosted Zoneの4つのName Serverと異なる場合は、現在の権威DNS側へレコードを追加する

## 用語の違い

| 用語 | 対象 |
|---|---|
| Custom domain mapping | 独自ドメインをCloud Runへ割り当てる |
| CORS | ブラウザから別オリジンへアクセスできるかを制御する |
| Cross-region | 複数リージョンのサービスを構成する |

domain mappingを設定しても、CORS、Cookie、OAuth、IAM認証は別途設定が必要

## 仕組み

Cloud Runが生成するURLの代わりに独自ドメインを公開する

```text
https://SERVICE-IDENTIFIER.REGION.run.app
                  ↓
https://dashboard.example.com
```

リクエストの流れ

```text
Browser
  |
  | https://dashboard.example.com
  v
DNS
  |
  | CNAME / A / AAAA
  v
Googleのフロントエンド
  |
  | Host header / TLS SNI
  v
Cloud Run domain mapping
  |
  v
Cloud Run service
```

ブラウザのURLは`dashboard.example.com`のままになり、Google側はホスト名から対象サービスを識別する

## 方式を選ぶ

| 用途 | 推奨方式 |
|---|---|
| 開発環境、社内画面、検証用URL | Cloud Run domain mapping |
| 小規模で停止影響が軽いサービス | Cloud Run domain mappingも選択肢 |
| 本番顧客向けサービス | Global external Application Load Balancer |
| Cloud ArmorやCloud CDNが必要 | Global external Application Load Balancer |
| パス単位で複数サービスへ振り分ける | Global external Application Load Balancer |
| ワイルドカードやURL maskが必要 | Global external Application Load Balancer |

直接domain mappingには次の制約がある

 - Previewで本番利用は推奨されていない
 - カスタムドメイン経由の高レイテンシが発生する場合がある
 - 特に`asia-northeast1`と`us-east4`で高レイテンシが目立つ可能性がある
 - マッピングできるのは`/`だけで、`/api`などのパスは指定できない
 - ワイルドカード証明書を利用できない
 - 独自の自己管理証明書をアップロードできない
 - ドメインマッピングは64文字まで
 - TLS 1.0とTLS 1.1を無効化できない

本番向けの推奨構成

```text
DNS A / AAAA
  |
  v
Global external Application Load Balancer
  |-- Google-managed certificate
  |-- URL map
  |-- Cloud Armor
  |-- Cloud CDN
  v
Serverless NEG
  |
  v
Cloud Run
```

## 前提

 - Cloud Runサービスがデプロイ済み
 - デフォルトの`run.app` URLが有効
 - 対象ドメインのDNSレコードを変更できる
 - `gcloud`で対象プロジェクトとGoogleアカウントを選択済み
 - 利用リージョンが直接domain mappingへ対応している

2026-07-19時点の対応リージョン

 - `asia-east1`
 - `asia-northeast1`
 - `asia-southeast1`
 - `europe-north1`
 - `europe-west1`
 - `europe-west4`
 - `us-central1`
 - `us-east1`
 - `us-east4`
 - `us-west1`

## ドメイン所有権を確認する

### アカウントとプロジェクトを確認する

```console
$ gcloud auth list
$ gcloud config get-value account
$ gcloud config get-value project
```

検証済みドメインを確認する

```console
$ gcloud domains list-user-verified
```

`dashboard.example.com`を使う場合は、通常ベースドメインの`example.com`を検証する

```console
$ gcloud domains verify example.com
```

Search Consoleの検証画面で指定されたTXTレコードをDNSへ追加する

```text
google-site-verification=VERIFICATION_TOKEN
```

### 検証したユーザとgcloudのアカウントを合わせる

ドメイン所有権はGoogle CloudプロジェクトのIAMだけでなく、検証したGoogleユーザにも紐づく

```text
Search Consoleで検証したアカウント
alice@example.com

gcloudで有効なアカウント
bob@example.com
```

`bob@example.com`がプロジェクトのIAM権限を持っていても、検証済み所有者でなければ新しいマッピングを追加できない場合がある

別のユーザまたはサービスアカウントから操作する場合は、Search Consoleの検証済み所有者へ追加する

## Cloud Runへドメインをマッピングする

直接domain mappingの`gcloud`コマンドは現在もBeta

```console
$ gcloud beta run domain-mappings create \
  --service=SERVICE_NAME \
  --domain=dashboard.example.com \
  --region=asia-northeast1
```

作成済みマッピングを確認する

```console
$ gcloud beta run domain-mappings describe \
  --domain=dashboard.example.com \
  --region=asia-northeast1
```

一覧を確認する

```console
$ gcloud beta run domain-mappings list \
  --region=asia-northeast1
```

別サービスに割り当て済みのドメインを移す場合は`--force-override`を使えるが、既存サービスからマッピングが外れるため注意

## DNSレコードを設定する

`describe`結果の`status.resourceRecords`にDNSへ追加するレコードが表示される

サブドメインでの出力例

```yaml
resourceRecords:
- name: dashboard
  rrdata: ghs.googlehosted.com.
  type: CNAME
```

 - サブドメインではCNAMEになることが多い
 - ルートドメインではAとAAAAが返る場合がある
 - `ghs.googlehosted.com`を決め打ちせず、`resourceRecords`の全レコードをそのまま設定する
 - DNS事業者の入力形式に合わせて末尾の`.`やホスト名を調整する

CNAMEを確認する

```console
$ dig +short CNAME dashboard.example.com
ghs.googlehosted.com.
```

ルートドメインでAまたはAAAAが返された場合はそれぞれ確認する

```console
$ dig +short A example.com
$ dig +short AAAA example.com
```

以前のDNSレコードとTTLによっては反映に数時間かかる場合がある

## TLS証明書とHTTPSを確認する

DNSがGoogleへ到達すると、Google-managed certificateが自動発行され、その後も自動更新される

証明書発行は通常約15分で、最大24時間かかる場合がある

マッピング状態を確認する

```console
$ gcloud beta run domain-mappings describe \
  --domain=dashboard.example.com \
  --region=asia-northeast1 \
  --format='yaml(status.conditions,status.resourceRecords)'
```

HTTPSを確認する

```console
$ curl -Iv https://dashboard.example.com/
```

SNIを指定して証明書を確認する

```console
$ openssl s_client \
  -connect dashboard.example.com:443 \
  -servername dashboard.example.com </dev/null
```

`-servername`で送るSNIを使い、Google側が対象ホストの証明書とルーティング先を識別する

証明書発行の内部実装をACMEやLet's Encryptと決めつけず、Google-managed certificateとしてGoogleへ発行と更新を委任すると理解する

## CORS、Cookie、OAuthを確認する

domain mappingはDNSとHTTPSの入口を作る機能で、CORSを変更しない

```text
Frontend: https://dashboard.example.com
API:      https://api.example.com
```

scheme、host、portのいずれかが違う場合は別オリジン

API側で必要なオリジンを許可する

```http
Access-Control-Allow-Origin: https://dashboard.example.com
Access-Control-Allow-Credentials: true
Vary: Origin
```

 - Cookieを使う場合は`Domain`、`SameSite`、`Secure`を確認する
 - OAuthを使う場合は認証事業者へ新しいredirect URIを登録する
 - Credential付きCORSでは`Access-Control-Allow-Origin: *`を使わない

## IAM認証でcustom audienceを設定する

IAMで保護したCloud Runサービスは、ID tokenの`aud`が受信サービスのURLと一致する必要がある

クライアントが`run.app` URLではなく独自ドメインをaudienceとして使う場合は、custom audienceを追加する

```console
$ gcloud run services update SERVICE_NAME \
  --add-custom-audiences=https://dashboard.example.com \
  --region=asia-northeast1
```

この設定変更では新しいリビジョンが作成される

## トラブルシューティング

### ドメインを作成できない

 - `gcloud config get-value account`とSearch Consoleの検証済み所有者を比較する
 - プロジェクトIAMだけで解決しない場合は、操作ユーザまたはサービスアカウントを検証済み所有者へ追加する
 - サブドメインではなくベースドメインを検証しているか確認する

### 証明書が発行されない

 - `resourceRecords`の全レコードを設定したか確認する
 - 古いA、AAAA、CNAMEが競合していないか確認する
 - デフォルトの`run.app` URLが有効か確認する
 - DNSのTTLと伝播を確認する
 - CDNやプロキシが証明書検証リクエストを遮断していないか確認する
 - Cloudflareを使う場合は`Always use HTTPS`が検証を妨げていないか確認する
 - 最大24時間までは証明書発行を待つ

### カスタムドメインだけ遅い

 - `run.app` URLとカスタムドメインの応答時間を比較する
 - `asia-northeast1`または`us-east4`では既知の高レイテンシ問題を確認する
 - 本番用途ではGlobal external Application Load BalancerとServerless NEGへ移行する

### IAM認証で401または403になる

 - ID tokenの`aud`を確認する
 - 独自ドメインをcustom audienceへ追加する
 - 呼び出し元に`roles/run.invoker`があるか確認する

## マッピングを削除する

```console
$ gcloud beta run domain-mappings delete \
  --domain=dashboard.example.com \
  --region=asia-northeast1
```

削除後は不要になったDNSレコードも削除する

## 参考

 - [Mapping custom domains](https://docs.cloud.google.com/run/docs/mapping-custom-domains)
 - [gcloud beta run domain-mappings](https://docs.cloud.google.com/sdk/gcloud/reference/beta/run/domain-mappings)
 - [Known issues in Cloud Run](https://docs.cloud.google.com/run/docs/known-issues)
 - [Set custom audiences for services](https://docs.cloud.google.com/run/docs/configuring/custom-audiences)
 - [Set up a global external Application Load Balancer with Cloud Run](https://docs.cloud.google.com/load-balancing/docs/https/setting-up-https-serverless)
 - [How domain registration works - Amazon Route 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/welcome-domain-registration.html)
 - [Creating records by using the Amazon Route 53 console](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resource-record-sets-creating.html)
