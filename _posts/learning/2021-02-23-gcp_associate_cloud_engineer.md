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
 - gcpの資格の一つ
 - 基礎的でかんたんなものに分類される
 - [***他の認定の説明***](https://gink03.github.io/gcp_certificates/)

## 出題範囲
 - [link](https://cloud.google.com/certification/guides/cloud-engineer?hl=ja)

## 知識体系


### プロジェクト
   - ***プロジェクトの課金の管理について*** 
	 - `50%`, `90%`, `100%`でアラートが来るようにするのがプラクティス
	 - `お支払い` -> `予算とアラート` -> `予算を作成`からアラートを作成する

### 見積もりツール
 - [calculator](https://cloud.google.com/products/calculator?hl=ja)というツールが提供されている

### cloud sdk
 - ***設定の確認***
   - *設定の確認*
	 - `gcloud config configurations list`
   - *有効になっているアカウントの確認*
	 - `gcloud auth list`
	 - 有効になっていない場合、これで認証できる　
   - *有効になっているプロジェクトの確認*
	 - `gcloud config list project`
 - ***zone, regionの設定と確認***
   - *ゾーンの設定*
   　- `gcloud config set compute/zone us-central1-a`
   - *リージョンの設定*
	 - `gcloud config set compute/region us-central1`
   - *設定の有効化*
	 - `gcloud config configurations activate`
 - ***サービスアカウントでSDKを有効化する***
   - *クレデンシャル情報でセットする*
	 - `gcloud auth activate-service-account my-service-account@my-project.gserviceaccount.com --key-file my-key.json --project my-project`
   - *セットされたか確認*
	 - `gcloud config list`
 - ***拡張機能の追加***
   - `gcloud components install [拡張機能]`
 - ***その他雑多なコマンド***
   - *環境変数へproject_idを入れる*
	 - `export PROJECT_ID=$(gcloud info --format='value(config.project)')`

### cloud iam
 - ***IAMの設定方針***
   - 最小のスコープに設定するように推奨
 - ***構造***
   - *階層構造*
	 - `組織` > `フォルダー` > `プロジェクト` > `リソース`
 - ***サービスアカウント***
   - *スコープ*
	 - 最小限のスコープで作る
   - *時間差の存在* 
	 - サービスアカウントで許可した機能は、一定の時間差があって反映される
   - *web ui*
	 - jsonのキーをダウンロード
   - *アカウントの作成*
	 - `gcloud iam service-accounts create test-service-account2 --display-name "test-service-account2"`
   - *service accountのロールの指定*
	 - `gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member serviceAccount:test-service-account2@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com --role roles/viewer`
   - *gcloud sdkをサービスアカウントで有効にする*
	 - `gcloud auth activate-service-account --key-file credentials.json`
 - ***実運用上のベストプラクティス***
   - *本番と開発を分ける方法*
	 - プロジェクトを分けるのが最もかんたん

### cloud identity
 - ***概要***
   - IDaaS(サービスとしてのID)
 - ***対応しているサービス***
   - Azure Active Directory

### deployment manager
 - ***概要***
   - *teraformのようなもの*
	 - teraformよりわかりやすい
   - *yml形式で記述する(拡張機能でjinja形式をimportできる)*
	 - docker imageとスケールサイズと最大数等を指定する内容
 - ***有効化***
   - cloud API経由
 - ***デプロイ関連***
   - *デプロイ*
	 - `gcloud deployment-manager deployments create ${PRJ} --config nodejs.yaml`
   - *dry-runについて*
	 - `preview`オプションをつける
	   - `gcloud deployment-manager deployments update ${PRJ} --config ${CONFING_YAML}.yml --preview`
   - *完了後に実行*
	 - `gcloud deployment-manager deployments update ${PRJ}`
 - ***実際にさわってみる***
   - [link](https://www.coursera.org/learn/gcp-infrastructure-scaling-automation-jp/gradedLti/iHo4x/rabo-deployment-manager-woshi-yong-sitenetutowakunoinhurasutorakutiyawozi-dong)

### terraform
 - ***概要***
   - `cloud shell`に最初から入っているツール
   - `deployment manager`のalternative
   - *書式*
	 - `tf`という謎形式で記述されている
 - ***execution planを作成***
   - `terraform plan`
 - ***実際に実行***
   - `terraform apply`

### cloud storage
 - ***コスト***
   - `Standard` > `Nearline` > `Coldline` > `Archive`
 - ***バージョニング***
   - 確認
	 - `gsutil versioning get gs://$BUCKET_NAME_1`
   - オンにする
	 - `gsutil versioning set on gs://${BUCKET_NAME}`
 - ***セキュリティ関係***
   - *概要*
	 - アクセスログがある
	 - デフォルトで暗号化は適応される
   - パスワードの設定
	 - `-o "GSUtil:encryption_key=${KEY}"`
   - *alc*
	 - `acl`の確認
	   - `gsutil alc get gs://$BUCKET_NAME_1/$FILENAME`
	 - `acl`のセット
	   - `gsutil acl set private gs://$BUCKET_NAME_1/$FILENAME`
	 - `ch`でユーザの変更
	   - `gsutil acl ch -u AllUsers:R gs://$BUCKET_NAME_1/$FILENAME`
	 - `iam`で限定する
	   - `gsutil iam ch allUsers:objectViewer gs://$MY_BUCKET_NAME_1`
	 - *privateにセット*
	   - `gsutil acl set private gs://$MY_BUCKET_NAME_1/cat.jpg`
	 - *publicにセット*
	   - `gsutil defacl set public-read gs://~~`
 - ***lifecycle***
   - *概要*
	 - jsonファイルでstrageのライフサイクルを定義できる
   - *具体的なセット方法*
	 - `gsutil lifecycle set life.json gs://$BUCKET_NAME_1`
   - *ライフサイクルの構成要素*
	 - `action`, `condition`の要素でなる 
	   - `type`
	   - `age`
 - ***操作一般***
   - *copy*
	 - `gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg gs://$MY_BUCKET_NAME_2/cat.jpg`
   - *rsync*
	 - ディレクトリまるごとrsyncできる
	 - `gsutil rsync -r ./firstlevel gs://$BUCKET_NAME_1/firstlevel`
   - *通信が失敗したときの再開フラグ*
     - `uploadType`を`resumable`にする
 - ***雑多な知識***
   - *.boto*
	 - `encryption_key`と`decription_key1~`で符号化と解読ができる
	 - pythonのインラインコマンドでキーの作成ができる
	   - `python3 -c 'import base64; import os; print(base64.encodebytes(os.urandom(32)))'`

### cloud datastore
 - ***概要***
   - ACIDトランザクションをサポート
	 - トランザクション処理の信頼性を担保するために作られた性質
   - スキーマレスデータベース
   - NoSQL
 
### cloud memorystrage
 - ***概要***
   - redis, memcached的なもの
   - ユースケースとして高速にアクセスしたい場合

### cloud dataproc
 - ***概要***
   - apache sparkのようなもの
   - apache hadoopの代替にもなる
   - レガシープロダクトが多い
   - レコメンドエンジン等を作ることもできる
  
### cloud security scanner
 - ***概要***
   - *セキュリティチェックツール*
	 - App Engineのセキュリティチェック
	 - XSS, Flashインジェクション, 混在コンテンツをチェックできる

### compute engine
 - ***インスタンス操作***
   - *カスタムインスタンスの作成*
	 - `gcloud compute instances create my-instance --custom-cpu 4 --custom-memory 8`とか
   - *スタートアップスクリプト*
	 - `gcloud compute instances create my-instance --metadata-from-file startup-script=${SCRIPT_PATH}`
	 - 起動時にインストールしておきたいスクリプトを入れる等
 - ***インスタンスグループ操作***
   - *ターゲットプールの作成*
	 - `gcloud compute target-pools create ${NAME}`
   - *インスタンステンプレートを使ったグループの作成*
	 - `gcloud compute instance-groups managed create nginx-group --base-instance-name nginx --size 2 --template nginx-template --target-pool nginx-pool`
   - *autoscalingする*
	 - `gcloud compute instance-groups managed set-autoscaling my-instance-group --max-num-replica ${NUM} --taget-cpu-utilization ${FLOAT}`
   - *具体的なオートスケールできるインスタンスグループの作り方*
	 - 必要なimageを作成する
	 - インスタンステンプレートでimageを設定し、オートスケールの条件を入力し、最大と最小のインスタンス数を記述する
 - ***雑多な知識***
   - *ログ*
	 - `cloud audit log`の`システムイベントログ`に情報が記される
   - *sdk経由でsshする*
	 - `gcloud compute ssh ${NAME}@{HOST}`
   - *イメージ名の検索*
	 - `gcloud compute images list --filter=name:${QUERY}`
   - *証跡・フォレンジック*
	 - vpcフローログというもので可能らしい
   - *スタートアップスクリプト*
	 - `meta`のタグに指定する
	   - `key`: `startup-script-url`
	   - `value`: `gs://cloud-training/gcpnet/ilb/startup.sh`

### cloud vpn
 - リージョンをまたいでVPNを設定できる
 - IPを固定して、トンネルをweb uiで設定して作るイメージ

### cloud interconnect
 - オンプレとVPCをつなぐもの
   - 大容量、専用契約が必要で、それに満たない場合cloud router + cloud vpnで代替できる
 - 速度と設備投資ごとに`Dedicated interconnect` > `Partner interconnect` > `cloud vpn`
 - ISPを経由して接続する`キャリアピアリング`というものもある

### transfer appliance
 - オフラインデータ転送サービス

### bigquery  
 - クエリの作成
   - `bq query "select ... from ..."`
 - 料金の見積もり
   - `bq query --dry_run`でバイト数を特定し、calculatorで料金を特定する
   - compute engineの見積もりツールと同じツールからできる　
 - csvでエクスポート
   - `bq extract ${TABLE} gs://${BUCKET}/${NAME}.csv`
 - bucket.tableを作る
   - `bq mk --time_partitioning_field timestamp --schema ride_id:string,point_idx:integer,latitude:float,longitude:float,timestamp:timestamp,meter_reading:float,meter_increment:float,ride_status:string,passenger_count:integer -t ${BUCKET}.${TABLE}`
   - この例では`timestamp`を`time_partitioning_field`としている
 - `webui`からできること
   - csvのアップロード&取り込み
   - schemaは手動で定義することもできる
	 - `name:string,gender:string,count:integer`
  
### cloud sql
 - ***概要***
   - mysqlのマネージドインスタンスを作れる
 - ***cloud sql proxy***
   - オンプレとcloud sqlをつなぐ機能
 - ***操作***
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
  
### cloud spanner
 - ***概要***
   - マルチリージョンサポートのデータベース
   - リージョンをまたいで低レイテンシでアクセスできる
     - この特徴があるので世界中に顧客がいる場合にユースケースが適合する
   - リレーショナル・データベース
   - `99.999%`以上の極めて高い可用性がある

### cloud bigtable
 - ***概要***
   - 膨大なデータでIoT、時系列、書き換えが発生する処理で有利
   - スキーマレスでNoSQLである

### cloud armor
 - ***概要***
   - SQLインジェクション等があったときに防ぐもの
 - ***適応***
   - `gcloud compute security-policies create --expression "evaluatePreconfiguredExpr('sqli-canary')" --action deny-403`

### cloud function
 - ***サンプルコード***
   - `https://github.com/GoogleCloudPlatform/nodejs-docs-samples.git`の`nodejs-docs-samples/functions/helloworld/`
 - ***デプロイ***
   - `gcloud functions deploy helloGET --runtime nodejs10 --trigger-http --allow-unauthenticated`
 - ***テスト***
   - `gcloud functions describe helloGET`
 - ***削除***
   - `gcloud functions delete helloGET`

### app engine
 - ***料金の見積もり***
   - App Engineの[料金計算ツール](https://cloud.google.com/products/calculator?hl=ja)を使って見積もる
 - ***デプロイ***
   - *サンプルプロジェクト*
	 - `gsutil cp gs://cloud-training/archinfra/gae-hello/* .`
   - *デプロイ*
	 - `gcloud app deploy app.yaml`
   - *アクセス用のURLを得る*
     - `gcloud app browse`
	 - web UIでも確認することができる
 - ***テスト****
   - `env: flex`にして、`gcloud app deply ~~ -=no-promote`で行う
 - ***どんな構成でデプロイ可能なのか***
   - dockerのプロジェクトのような構造でDockerfileの代わりに`app.yaml`が存在するのが特徴
   - [サンプルとなるサイト](https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses/design-process/deploying-apps-to-gcp)
   - コンテナは利用できない
 - ***versioning***
   - *概要*
	 - バージョンごとに異なるURLが与えられ、`versions`の機能から`split traffic`の機能でバージョンごとのトラフィックの分割、マイグレーションがコントロール可能
   - *カナリアテスト*
	 - 配信を限定して事故を防ぐ
   - *ローリングアップデート*
	 - ダウンタイムゼロでアップデートする
   - *blue greenデプロイ*
	 - blueがv1, greenがv2
	 - トラフィックを割り振る
 - ***profiling***
   - *概要*
	 - app engineでどの部分がどの程度のパフォーマンス消費なのか確認できる
   - *具体的な利用法*
	 - pythonで実行する際、`import googlecloudprofiler`して埋め込むことでprofilerを利用できる

### loadbalancer
 - ***具体的な利用法***
   - `cloud nat`を作成する
   - ゾーン、リージョンでまたいでも良いインスタンスグループを用意する
   - loadbalancerをセットアップする
 - ***cli***
   - *ネットワークロードバランサの作成*
	 - `gcloud compute forwarding-rules create ${LB_NAME} --region us-central1 --ports=80 --target-pool ${TARGET_POOL}`
   - *HTTPロードバランサの作成*
     - `gcloud compute http-health-checks create http-basic-check`
	 - `gcloud compute backend-services create nginx-backend --protocol HTTP --http-health-checks http-basic-check --global`
	 - `gcloud compute backend-services add-backend nginx-backend --instance-group nginx-group --instance-group-zone us-central1-a --global`
	 - `gcloud compute url-maps create web-map --default-service nginx-backend`
	 - `gcloud compute target-http-proxies create http-lb-proxy --url-map web-map`
 - ***その他雑多な知識***
   - ipv6も利用できる
   - HTTP(S), SSLプロキシ、TCPプロキシ、ネットワーク、内部負荷の分散が利用できる

### cloud HSM
 - `FIPS 130-2 level 3`のハードウェア・セキュリティ・モジュールのこと

### kubernetes engine
 - 導入
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
   - services, podsの停止
	 - `kubectl stop pods,services`
   - podsの削除
	 - `kubectl delete pods`
   - servicesの削除
	 - `kubectl delete service hello-srver-service`
   - ノードプールの作成
	 - `gcloud container node-pools create $POOL_NAME --cluster $CLUSTER_NAME`
   - ノードプールの確認
	 - `gcloud container node-pools list --cluster $CLUSTER_NAME`
   - ノードプールの詳細を確認
	 - `gcloud container node-pools describe $POOL_NAME --cluster $CLUSTER_NAME`
   - ノードプールのサイズを変更
	 - `gcloud container clusters resize $CLUSTER_NAME --node-pool $POOL_NAME --num-nodes $NUM_NODES`
 - ***基本用語***
   - namespace
	 - 開発とプロダクションを分けるときなど、namespaceできるのが良い
   - 種類
     - オートパイロットとそうでないものがある
   - pod
	 - 一番小さい粒度のkubernetesオブジェクト
	 - 幾つかのコンテナの集まり
   - service
     - podを複数束ねた粒度
   - cluster
	 - serviceを複数束ねた粒度
 - ***`kubectl`コマンドについて***
   - `kube-apiserver`をラップしたもの
   - 最初にkubectlコマンドを使えるようにする
     - `gcloud container clusters get-credentials ${CLUSTER_NAME}`でkubeconfigエントリを作成する
 - ***監視***
   - livenessプローブ
	 - ちゃんと起動しているか
   - readinessプローブ
	 - コンテナがトラフィックを受け付けているか
 - ***クラスタ操作関連***
   - クラスタを作成する
	 - `gcloud container clusters get-credentials ${CLUSTER_NAME}`
	 - web uiからクラスタを編集することができる
   - クラスタサイズのリサイズ
	 - `gcloud container clusters resize`
	 - `kubectl ~~`ではできない
   - クラスタを削除する
     - `gcloud container clusters delete ${CLUSTER_NAME}`
   - クラスタの一覧
     - `gcloud container clusters list`
 - ***デプロイメント関連***
   - web uiからコンテナをデプロイすることもできる
   - *デプロイメントの作成*
	 - `kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0`
   - *scaleする(レプリカのベースラインを変更する)*
	 - `kubectl scale deployment hello-server --replicas=3`
   - *deploymentのhorizontal pod autoscalerリソースを作成する*
	 - `kubectl autoscal deployment hello-server --cpu-percent=80 --min=1 --max=5`
   - *exposeする(インターネットに公開する)*
	 - `kubectl expose deployment hello-server --type="LoadBalancer" --port 8080`
   - *exposeする(ロードバランサを使用)*
	 - `kubectl expose deployment ${MY_DEPLOY} --type LoadBalancer --port 80 --target-port 8080`
   - *ローリングアップデートをする*
	 - `kubectl set image deployment/hello-server hello-server=gcr.io/${PROJECT_ID}/hello-server:v2`
 - ***ベストプラクティス***
   - 低レイテンシにする
	 - 同じpodにコンテナを配置する
   - ロギング
	 - クラスタ作成時にStackdriver Loggingをオンにする + Stackdriver Loggingのエクスポート機能を利用してBQに書き込む
   - ワーカーノードのスケーリング
	 - Kubernetes Engineでスケーリングする
   - コンテナ間で通信する
	 - `LoadBalancer`を使用すると外部に公開されてしまうので使用できない
   - バックアップが必要な場合マルチリージョンで並列化することになる
	 - コントロールプレーンがゾーンの上にあるため
   - サードパーティのツールを入れたい
	 - `DaemonSet`にpodを配置する


### cloud run
 - 概要
   - 薄いdockerを走らせるためのサービス
   - kubernetesより設定が少なくかんたん

### container registry
 - ***API有効化***
   - `gcloud services enable containerregistry.googleapis.com`
 - ***dockerからcontainerregistryの認証を通す***
   - `gcloud auth configure-docker`
 - ***push***
   - `docker push gcr.io/${PROJECT_ID}/hello-app:v1`

### stack driver
 - ***モニタリング***
   - アプリのパフォーマンス、稼働時間等
   - `metrics explorer`でメトリクスを定義する
   - `alerting`で通知先等を定義する
   - `groups`でグループをまとめる
 - ***トレース***
   - モニタリングより解像度が高い
   - パフォーマンスの低下の原因などを追求できる
 - ***デバッガー***
   - パフォーマンスのボトルネックをあぶり出す
 - ***ロギング***
   - ログング


### service levelの設計
 - ***設計***
   - who, what, why, when, howに基づいて設計する
   - ペルソナを用いる
 - ***各項目***
   - sla: service level agreement
     - サービスの最低とするライン　
   - slo: service level objective
	 - サービスの定量的な目標値
 - ***smart***
   - specific, measurable, achievable, related, time-bound
   - UX等は含まれない

### apiの設計
 - ***restful***
   - json, xml, htmlなどを返して良い
 - ***無効なリクエストに対するハンドル***
   - 400番台のエラーコード
 - ***the twelve-factor appに基づいて設計すると良い***
   - [参考](https://qiita.com/supreme0110/items/17c58c660137e23ef713)

### cloud build
 - ***dockerコンテナを手動デプロイする***
   - `yaml`を作成する
   - `gcloud builds submit --config cloudbuild.yaml .`
 - ***レポジトリ連携***
   - レポジトリ内のbuild triggerを有効にして利用できる　
   - レポジトリにあるdockerコンテナをビルドするもの
   - masterブランチが更新されると自動的にhookされてビルドされる 
   - ビルドされたイメージはcloud computeにデプロイできる
