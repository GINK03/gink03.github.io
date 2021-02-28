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
 - 有効になっているアカウントの確認
   - `gcloud auth list`
   - 有効になっていない場合、これで認証できる　
 - 有効になっているプロジェクトの確認
   - `gcloud config list project`
 - ゾーンの設定をする
 　- `gcloud config set compute/zone us-central1-a`
 - リージョンの設定をする
   - `gcloud config set compute/region us-central1`
 - 設定の有効化
   - `gcloud config configurations activate`
 - サービスアカウントでSDKを有効化する
   - *クレデンシャル情報でセットする*
	 - `gcloud auth activate-service-account my-service-account@my-project.gserviceaccount.com --key-file my-key.json --project my-project`
   - *ちゃんとセットされたか確認*
	 - `gcloud config list`
 - 拡張機能の追加
   - `gcloud components install ${拡張機能}`
 - 環境変数へproject_idを入れる
   - `export PROJECT_ID=$(gcloud info --format='value(config.project)')`

**cloud iam**  
 - 階層構造になっている
   - `組織` > `フォルダー` > `プロジェクト` > `リソース`
 - 最小限のリスクになるようにする
 - **サービスアカウント**
   - サービスアカウントで許可した機能は、一定の時間差があって反映される
   - 最小限のスコープで作る
   - web uiからjsonのキーをダウンロードできる
   - *作成*
	 - `gcloud iam service-accounts create test-service-account2 --display-name "test-service-account2"`
   - *ロールの指定*
	 - `gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member serviceAccount:test-service-account2@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com --role roles/viewer`
   - *gcloudをサービスアカウント有効にする*
	 - `gcloud auth activate-service-account --key-file credentials.json`
 - 本番と開発を分ける方法
   - プロジェクトを分けるのが最もかんたん
 - 作成したgoogle groupにiamをバインディングする
   - `gcloud projects add-iam-policy-binding`

**deployment manager**  
 - **実際にさわってみる**
   - [link](https://www.coursera.org/learn/gcp-infrastructure-scaling-automation-jp/gradedLti/iHo4x/rabo-deployment-manager-woshi-yong-sitenetutowakunoinhurasutorakutiyawozi-dong)
 - cloud APIからこの機能を有効にできる
 - teraformのようなもの
   - teraformよりわかりやすい
 - yml形式で記述する(拡張機能でjinja形式をimportできる)
   - docker imageとスケールサイズと最大数等を指定する　
 - `yaml`のデプロイについて
   - `gcloud deployment-manager deployments create ${PRJ} --config nodejs.yaml`
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

**cloud storage**  
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
   - デフォルトで暗号化は適応される
 - **一般操作**
   - *copy*
	 - `gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg gs://$MY_BUCKET_NAME_2/cat.jpg`
   - *aclの取得*
	 - `gsutil acl get gs://$MY_BUCKET_NAME_1/cat.jpg  > acl.txt`
   - *privateにセット*
	 - `gsutil acl set private gs://$MY_BUCKET_NAME_1/cat.jpg`
 - **alc**
   - `acl`の確認
     - `gsutil alc get gs://$BUCKET_NAME_1/$FILENAME`
   - `acl`のセット
	 - `gsutil acl set private gs://$BUCKET_NAME_1/$FILENAME`
   - `ch`でユーザの変更
     - `gsutil acl ch -u AllUsers:R gs://$BUCKET_NAME_1/$FILENAME`
   - `iam`で限定する
	 - `gsutil iam ch allUsers:objectViewer gs://$MY_BUCKET_NAME_1`
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
 - NoSQL
 
**cloud memorystrage**
 - redis, memcached的なもの
 - ユースケースとして高速にアクセスしたい場合

**cloud dataproc**  
 - apache sparkのようなもの
 - apache hadoopの代替にもなる
 - レガシープロダクトが多い
 - レコメンドエンジン等を作ることもできる
  
**cloud security scanner**  
 - App Engineのセキュリティチェック
 - XSS, Flashインジェクション, 混在コンテンツをチェックできる

**computing engine**
 - ログ
   - `cloud audit log`の`システムイベントログ`に情報が記される
 - スタートアップスクリプト
   - `gcloud compute instances create my-instance --metadata-from-file startup-script=${SCRIPT_PATH}`
   - 起動時にインストールしておきたいスクリプトを入れる等
 - カスタムインスタンスの作成
   - `gcloud compute instances create my-instance --custom-cpu 4 --custom-memory 8`とか
 - インスタンスグループの作成
   - `gcloud compute target-pools create ${NAME}`
 - インスタンステンプレートを使ったグループの作成
   - `gcloud compute instance-groups managed create nginx-group --base-instance-name nginx --size 2 --template nginx-template --target-pool nginx-pool`
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
   - 大容量、専用契約が必要で、それに満たない場合cloud router + cloud vpnで代替できる
 - 速度と設備投資ごとに`Dedicated interconnect` > `Partner interconnect` > `cloud vpn`
 - ISPを経由して接続する`キャリアピアリング`というものもある

**transfer appliance**  
 - オフラインデータ転送サービス

**bigquery**  
 - bqのデフォルトプロジェクトの設定
   - `gcloud config set project ${PROJECT}`
 - 料金の見積もり
   - `bq query --dry_run`でバイト数を特定し、pricing calculatorで料金を特定する
 - csvでエクスポート
   - `bq extract ${TABLE} gs://${BUCKET}/${NAME}.csv`
 - bucket.tableを作る
   - `bq mk --time_partitioning_field timestamp --schema ride_id:string,point_idx:integer,latitude:float,longitude:float,timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,passenger_count:integer -t ${BUCKET}.${TABLE}`
   - この例では`timestamp`を`time_partitioning_field`としている
 - `webui`からできること
   - csvのアップロード&取り込み
   - schemaは手動で定義することもできる
	 - `name:string,gender:string,count:integer`
  
**cloud sql**  
 - **インスタンスの作成**
   - vmを作成する手順と一緒
 - **cloud sql proxy**
   - オンプレとcloud sqlをつなぐ機能
 - *操作*
   - *作成* 
	 - `gcloud sql instances create ${CLOUD_SQL_NAME} --tier=db-n1-standard-1 --activation-policy=ALWAYS`
   - *password set*
	 - `gcloud sql users set-password root --host % --instance ${CLOUD_SQL_NAME} --password Passw0rd`
   - *ipによる許可*
	 - `gcloud sql instances patch taxi --authorized-networks $ADDRESS`
   - *接続*
	 - `gcloud sql connect ${CLOUD_SQL_NAME} --user=root --quiet`
   - *mysqlimport*
	 - column情報を制作する
	 - `mysqlimport --local --host=$MYSQLIP --user=root --password --ignore-lines=1 --fields-terminated-by=',' bts trips.csv-*`
**cloud spanner**  
 - 特性
   - マルチリージョンサポートのデータベース
   - リージョンをまたいで低レイテンシでアクセスできる
     - この特徴があるので世界中に顧客がいる場合にユースケースが適合する
   - リレーショナル・データベース
   - `99.999%`以上の極めて高い可用性がある

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
	 - web UIでも確認することができる
 - どんな構成でデプロイ可能なのか
   - dockerのプロジェクトのような構造で`app.yaml`があること
   - [サンプルとなるサイト](https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses/design-process/deploying-apps-to-gcp)
   - コンテナは利用できない
 - versioning
   - バージョンごとに異なるURLが与えられ、`versions`の機能から`split traffic`の機能でバージョンごとのトラフィックの分割、マイグレーションがコントロール可能
   - カナリアテスト
	 - 配信を限定して事故を防ぐ
   - ローリングアップデート
	 - ダウンタイムゼロでアップデートする
   - `blue greenデプロイ`
	 - blueがv1, greenがv2
	 - トラフィックを割り振る
 - profiling
   - pythonで実行する際、`import googlecloudprofiler`して埋め込むことでprofilerを利用できる
 - monitoring
   - profilingされた内容の確認

**loadbalancer**  
 - **具体的な利用法**
   - `cloud nat`を作成する
   - ゾーン、リージョンでまたいでも良いインスタンスグループを用意する
   - loadbalancerをセットアップする
 - **cli**
   - ネットワークロードバランサ
	 - `gcloud compute forwarding-rules create ${LB_NAME} --region us-central1 --ports=80 --target-pool ${TARGET_POOL}`
   - HTTPロードバランサ
     - `gcloud compute http-health-checks create http-basic-check`
	 - `gcloud compute backend-services create nginx-backend --protocol HTTP --http-health-checks http-basic-check --global`
	 - `gcloud compute backend-services add-backend nginx-backend --instance-group nginx-group --instance-group-zone us-central1-a --global`
	 - `gcloud compute url-maps create web-map --default-service nginx-backend`
	 - `gcloud compute target-http-proxies create http-lb-proxy --url-map web-map`
 - ipv6も利用できる
 - HTTP(S), SSLプロキシ、TCPプロキシ、ネットワーク、内部負荷の分散が利用できる

**cloud HSM**  
 - `FIPS 130-2 level 3`のハードウェア・セキュリティ・モジュールのこと

**kubernetes engine**  
 - 導入
   - 種類
     - オートパイロットとそうでないものがあるがオートパイロットが便利
   - `app engine`と`docker`のプロジェクトをテンプレートとして使って作成可能
   - `app engine`は`app.yaml`が必要であるが、`kubernetes engine`は`kubernetes-config.yaml`で設定する
   - 設定完了したら`kubectl apply -f kubernetes-config.yaml`で適応できる
   - podの確認
	 - `kubectl get pods`
	 - デプロイ状況の確認(120秒以上かかる)
   - serviceの確認
     - `kubectl get services`
	 - コンテナの確認
	 - IPの確認
 - 低レイテンシにする
   - 同じpodにコンテナを配置する
 - `kubectl`コマンドについて
   - `kube-apiserver`をラップしたもの
 - namespace
   - 開発とプロダクションを分けるときなど、namespaceできるのが良い
 - 監視
   - livenessプローブ
	 - ちゃんと起動しているか
   - readinessプローブ
	 - コンテナがトラフィックを受け付けているか
 - クラスタを作成する
   - `gcloud container clusters get-credentials ${CLUSTER_NAME}`
   - web uiからクラスタを編集することができる
 - デプロイする
   - `kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0`
   - web uiからコンテナをデプロイすることもできる
 - exposeする
   - `kubectl expose deployment hello-server --type="LoadBalancer" --port 8080`
 - クラスタを削除する
   - `gcloud container clusters delete ${CLUSTER_NAME}`
 - クラスタの一覧
   - `gcloud container clusters list`
 - 最初にkubectlコマンドを使えるようにする
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


**cloud run**  
 - 概要
   - 薄いdockerを走らせるためのサービス
   - kubernetesより設定が少なくかんたん

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

**service levelの設計**  
 - who, what, why, when, howに基づいて設計する
 - ペルソナを用いる
 - 各項目
   - sla: service level agreement
     - サービスの最低とするライン　
   - slo: service level objective
	 - サービスの定量的な目標値
 - smart
   - specific, measurable, achievable, related, time-bound
   - UX等は含まれない

**apiの設計**  
 - restful
   - json, xml, htmlなどを返して良い
 - 無効なリクエストに対するハンドル
   - 400番台のエラーコード
 - the twelve-factor appに基づいて設計すると良い
   - [参考](https://qiita.com/supreme0110/items/17c58c660137e23ef713)

**cloud build**  
 - *手動デプロイする*
   - `yaml`を作成する
   - `gcloud builds submit --config cloudbuild.yaml .`
 - *レポジトリ連携*
   - レポジトリ内のbuild triggerを有効にして利用できる　
   - レポジトリにあるdockerコンテナをビルドするもの
   - masterブランチが更新されると自動的にhookされてビルドされる 
   - ビルドされたイメージはcloud computeにデプロイできる
