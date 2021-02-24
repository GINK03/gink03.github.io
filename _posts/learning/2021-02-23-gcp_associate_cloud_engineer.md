---
layout: post
title: "google cloud associate cloud engineer"
date: 2021-02-23
excerpt: "google cloud associate cloud engineer試験"
learning: true
tag: ["cloud"]
comments: false
---

# google cloud associate cloud engineer試験


## 概要

## 知識体系

**IAMの設定方針**  
 - 最小のスコープに設定するように推奨されている
 
**プロジェクトの課金の管理について**  
 - `50%`, `90%`, `100%`でアターとが来るようにするのがプラクティス

**cloud sdk**  
 - 設定の確認
   - `gcloud config configurations list`
 - 設定の有効化
   - `gcloud config configurations activate`
 - サービスアカウントでSDKを有効化する
   - `gcloud auth activate-service-account my-service-account@my-project.gserviceaccount.com --key-file my-key.json --project my-project`
 - 拡張機能の追加
   - `gcloud components install ${拡張機能}`

**cloud iam**  
 - 階層構造になっている
   - `組織` > `フォルダー` > `プロジェクト` > `リソース`
 - 最小限のリスクになるようにする
 - サービスアカウントで許可した機能は、一定の時間差があって反映される

**deployment manager**  
 - **実際にさわってみる**
   - [link](https://www.coursera.org/learn/gcp-infrastructure-scaling-automation-jp/gradedLti/iHo4x/rabo-deployment-manager-woshi-yong-sitenetutowakunoinhurasutorakutiyawozi-dong)
 - cloud APIからこの機能を有効にできる
 - teraformのようなもの
   - teraformよりわかりやすい
 - yml形式で記述する(拡張機能でjinja形式をimportできる)
 - dry-runについて
   - `gcloud deployment-manager deployments update ${PRJ} --config ${CONFING_YAML}.yml --preview`
   - `preview`オプションになる
 - dry-run完了後の実行
   - `gcloud deployment-manager deployments update ${PRJ}`

**terraform**  
 - `cloud shell`に最初から入っている
 - 書式
   - `tf`という謎形式で記述されている
 - リンター
   - `terraform fmt`
 - execution planを作成
   - `terraform plan`
 - 実際に実行
   - `terraform apply`

**cloud strage**  
 - コスト順
   - `Standard` > `Nearline` > `Coldline` > `Archive`
 - パスワードの設定
   - `-o "GSUtil:encryption_key=${KEY}"`
 - ファイルのバージョニング
   - 確認
	 - `gsutil versioning get gs://$BUCKET_NAME_1`
   - オンにする
	 - `gsutil versioning set on gs://${BUCKET_NAME}`
 - 通信が失敗したときの再開フラグ
   - `uploadType`を`resumable`にする
 - `public`に公開
   - `gsutil defacl set public-read gs://~~`
 - セキュリティの関係
   - アクセスログがあるらしい
 - **alc**
   - `acl`の確認
     - `gsutil alc get gs://$BUCKET_NAME_1/$FILENAME`
   - `acl`のセット
	 - `gsutil acl set private gs://$BUCKET_NAME_1/$FILENAME`
   - `ch`でユーザの変更
     - `gsutil acl ch -u AllUsers:R gs://$BUCKET_NAME_1/$FILENAME`
 - **.boto**
   - `encryption_key`と`decription_key1~`で符号化と解読ができる
   - pythonのインラインコマンドでキーの作成ができる
     - `python3 -c 'import base64; import os; print(base64.encodebytes(os.urandom(32)))'`
 - **lifecycle**
   - jsonファイルでstrageのライフサイクルを定義できる
   - `gsutil lifecycle set life.json gs://$BUCKET_NAME_1`
   - `action`, `condition`の要素でなる 
     - `type`
	 - `age`
 - **rsync**
   - ディレクトリまるごとrsyncできる
   - `gsutil rsync -r ./firstlevel gs://$BUCKET_NAME_1/firstlevel`

**cloud datastore**  
 - ACIDトランザクションをサポート
 - スキーマレスデータベース
 
**memorystore**
 - redis, memcached的なもの

**dataproc**  
 - apache sparkのようなもの
 - apache hadoopの代替にもなるらしい
  
**cloud security scanner**  
 - App Engineのセキュリティチェック
 - XSS, Flashインジェクション, 混在コンテンツをチェックできる

**computing engine**
 - ログ
   - `cloud audit log`の`システムイベントログ`に情報が記される
 - スタートアップスクリプト
   - `gcloud compute instances create my-instance --metadata-from-file startup-script=${SCRIPT_PATH}`
 - カスタムインスタンスの作成
   - `gcloud compute instances create my-instance --custom-cpu 4 --custom-memory 8`とか
 - イメージ名の検索
   - `gcloud compute images list --filter=name:${QUERY}`
 - 証跡・フォレンジック
   - vpcフローログというもので可能らしい
 - SDKでsshする
   - `gcloud compute ssh ${NAME}@{HOST}`
 - autoscalingする
   - `gcloud compute instance-groups managed set-autoscaling my-instance-group --max-num-replica ${NUM} --taget-cpu-utilization ${FLOAT}`
 - 起動しているコンピューティングエンジンの内部で他のプロジェクトのサービスアカウントを取り込んで有効化する
   - `gcloud auth activate-service-account --key-file qwiklabs-gcp-03-36c62e9f7fe3-5075f95894f6.json `
   - 例えばcloud strageを許可した他のプロジェクトのサービスアカウントを取り込むと他のプロジェクトのcloud strageにアクセスできる
 - 具体的なオートスケールできるインスタンスグループの作り方
   - 必要なimageを作成する
   - インスタンステンプレートでimageを設定し、オートスケールの条件を入力し、最大と最小のインスタンス数を記述する
 - スタートアップスクリプト
   - `meta`のタグに指定する
     - `key`: `startup-script-url`
	 - `value`: `gs://cloud-training/gcpnet/ilb/startup.sh`

**cloud vpn**  
 - リージョンをまたいでVPNを設定できる
 - IPを固定して、トンネルをweb uiで設定して作るイメージ

**cloud interconnect**  
 - オンプレとVPCをつなぐもの
 - 速度と設備投資ごとに`Dedicated interconnect` > `Partner interconnect` > `cloud vpn`
 - ISPを経由して接続する`キャリアピアリング`というものもある

**transfer appliance**  
 - オフラインデータ転送サービス

**big query**  
 - bqのデフォルトプロジェクトの設定
   - `gcloud config set project ${PROJECT}`
 - 料金の見積もり
   - `bq query --dry_run`でバイト数を特定し、pricing calculatorで料金を特定する
 - csvでエクスポート
   - `bq extract ${TABLE} gs://${BUCKET}/${NAME}.csv`
  
**cloud sql**  
 - **インスタンスの作成**
   - vmを作成する手順と一緒
 - **cloud sql proxy**
   - オンプレとcloud sqlをつなぐ機能

**cloud spanner**  
 - 特性
   - マルチリージョンサポートのデータベース
   - リージョンをまたいで低レイテンシでアクセスできる
   - リレーショナル・データベース

**cloud bigtable**  
 - 特性
   - 膨大なデータでIoT、時系列、書き換えが発生する処理で有利
   - スキーマレスでNoSQLである

**cloud armor**  
 - SQLインジェクション等があったときに防ぐもの
 - コマンド
   - `gcloud compute security-policies create --expression "evaluatePreconfiguredExpr('sqli-canary')" --action deny-403`

**app engine**  
 - 料金の見積もり
   - App Engineの[料金計算ツール](https://cloud.google.com/products/calculator?hl=ja)を使って見積もる
 - テスト用に実行する
   - `env: flex`にして、`gcloud app deply ~~ -=no-promote`で行う
 - デプロイ
   - サンプルプロジェクト
	 - `gsutil cp gs://cloud-training/archinfra/gae-hello/* .`
   - デプロイ
	 - `gcloud app deploy app.yaml`
   - アクセス用のURLを得る
     - `gcloud app browse`

**loadbalancer**  
 - **具体的な利用法**
   - `cloud nat`を作成する
   - ゾーン、リージョンでまたいでも良いインスタンスグループを用意する
   - loadbalancerをセットアップする
 - ipv6も利用できる
 - HTTP(S), SSLプロキシ、TCPプロキシ、ネットワーク、内部負荷の分散が利用できる

**cloud HSM**  
 - `FIPS 130-2 level 3`のハードウェア・セキュリティ・モジュールのこと

**kubernetes engine**  
 - 最初にkubectlを使えるようにする
   - `gcloud container clusters get-credentials ${CLUSTER_NAME}`でkubeconfigエントリを作成する
 - ロギング
   - クラスタ作成時にStackdriver Loggingをオンにする + Stackdriver Loggingのエクスポート機能を利用してBQに書き込む
 - ワーカーノードのスケーリング
   - Kubernetes Engineでスケーリングする
 - クラスタサイズのリサイズ
   - `gcloud container clusters resize`
   - `kubectl ~~`ではできない
 - コンテナ間で通信する
   - `LoadBalancer`を使用すると外部に公開されてしまう
 - バックアップが必要な場合マルチリージョンで並列化することになる
   - コントロールプレーンがゾーンの上にあるため
 - ロードバランサの公開
   - `kubectl expose deployment ${MY_DEPLOY} --type LoadBalancer --port 80 --target-port 8080`
 - サードパーティのツールを入れたい
   - `DaemonSet`にpodを配置する

**stack driver**  
 - **モニタリング**
   - アプリのパフォーマンス、稼働時間等
   - `metrics explorer`でメトリクスを定義する
   - `alerting`で通知先等を定義する
   - `groups`でグループをまとめる
 - **トレース**
   - モニタリングより解像度が高い
   - パフォーマンスの低下の原因などを追求できる
 - **デバッガー**
   - パフォーマンスのボトルネックをあぶり出す
 - **ロギング**
   - ログング

**ゾーン間のレプリケーション**  
 - `gcloud`コマンドではコピーできない
 - スナップショットを作成し、そのディスクから新規VMを作る

**トランザクションデータとリレーショナルデータ**  
 - 双方扱えるのが以下のプロダクト
   - `Cloud SQL`
   - `Cloud Database`

	  
