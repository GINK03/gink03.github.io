---
layout: post
title: "google cloud professional data engineer"
date: 2021-03-04
excerpt: "google cloud professional data engineer試験"
learning: true
tag: ["cloud"]
comments: false
---

# google cloud professional data engineer試験

## 出題範囲
 - [link](https://cloud.google.com/certification/guides/data-engineer)

## 参考資料
 - https://qiita.com/endw0901/items/5ebc530de3e9ffee4416
 - https://qiita.com/ieiringoo/items/2c2a585e50f1cf831ca8


## cloud data fusion
 - ***概要***
   - GUIで扱えるデータパイプライン
   - cloud dataprocのラッパーのようになっている
 - ***web uiでの例***
   - `Data Fusion`からインスタンスを作成(10分程度かかる)
   - ***wrangler*** 
     - gcsからcsvをインプットしたりしてその内容を特定のルールでパース
   - GUIから各プラグインをつなぎ、`input`, `join`, `output`を定義する
   - 各ソースにはbigqueryを用いることもできる
 - <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--6xZH0ZBx--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/suo2glzw21i4fca5y5di.png">

## cloud composer/airflow
 - ***特徴***
   - AirFlowで挙動を定義する
   - 起動に30分以上かかる
 - ***cui***
   1. environmentsの作成
     - `gcloud composer environments create example-environment`
   2. AirFlowで定義したdagをstorageにupload
     - pythonスクリプト
 - ***bigquery連携***
   - パーティショニングやクラスタリングをサポートした書き込みはcloud storageからschema.jsonを作成し、`GoogleCloudStorageToBigQueryOperator`でbigqueryに書き込む

## cloud audit logs
 - ***概要***
   - gcp上の監査ログを保存している
   - 管理アクティビティ、データアクセス、システムイベント、ポリシー拒否をロギングする
 - ***cui***
   - `project`
     - `gcloud logging read "logName : projects/PROJECT_ID/logs/cloudaudit.googleapis.com" --project=PROJECT_ID`
   - `folder`
     - `gcloud logging read "logName : folders/FOLDER_ID/logs/cloudaudit.googleapis.com" --folder=FOLDER_ID`
   - `organization`
     - `gcloud logging read "logName : organizations/ORGANIZATION_ID/logs/cloudaudit.googleapis.com" --organization=ORGANIZATION_ID`

## cloud dataproc
 - ***概要***
   - hadoop/spark alternative

## cloud dataflow/apache beam
 - ***概要***
   - apache beamをCLOUDでできるようにするもの
 - ***javaでの実行***
   - window処理
   - オンライン処理
 - ***pythonでの実行***

```python
import apache_beam as beam

def my_grep(line, term):
   if line.startswith(term):
      yield line

PROJECT='qwiklabs-gcp-02-0a2e4e893c3d'
BUCKET='qwiklabs-gcp-02-0a2e4e893c3d'
def run():
   argv = [
      '--project={0}'.format(PROJECT),
      '--job_name=examplejob2',
      '--save_main_session',
      '--staging_location=gs://{0}/staging/'.format(BUCKET),
      '--temp_location=gs://{0}/staging/'.format(BUCKET),
      '--region=us-central1',
      '--runner=DataflowRunner'
   ]
   p = beam.Pipeline(argv=argv)
   input = 'gs://{0}/javahelp/*.java'.format(BUCKET)
   output_prefix = 'gs://{0}/javahelp/output'.format(BUCKET)
   searchTerm = 'import'
   # find all lines that contain the searchTerm
   (p
      | 'GetJava' >> beam.io.ReadFromText(input)
      | 'Grep' >> beam.FlatMap(lambda line: my_grep(line, searchTerm) )
      | 'write' >> beam.io.WriteToText(output_prefix)
   )
   p.run()
if __name__ == '__main__':
   run()
```
    - `my_grep`を編集することで任意のデータの変換が可能
 - ***ウィンドウ各種***
   - TODO

## cloud bigtable
 - ***概要***
   - iot用のDB
   - hbaseを用いる
   - `pub/sub` -> `dataflow` -> `bigtable`で書き込む
   - [多数のノードからなる](https://qiita.com/kei0405/items/d420efebcc4b8fb1c008)
 - ***クエリ***
   - `scan 'current_conditions', {'LIMIT' => 2}`
   - `scan 'current_conditions', {'LIMIT' => 10, STARTROW => '15#S#1', ENDROW => '15#S#999', COLUMN => 'lane:speed'}`
   - startrow, endrowでクエリの範囲を決める
   - `data skew`を最小化することで高速化する
 

## cloud kms
 - ***概要***
   - 暗号化サービス
 - ***cui***
   - **キーリングの作成**
     - `gcloud kms keyrings create "test" --location "global"`
   - **キーの作成**
     - `gcloud kms keys create "quickstart" --location "global" --keyring "test" --purpose "encryption"`
   - **暗号化**
     - `gcloud kms encrypt --location "global" --keyring "test" --key "quickstart" --plaintext-file ./mysecret.txt --ciphertext-file ./mysecret.txt.encrypted`
   - **復号化**
     - `gcloud kms decrypt --location "global" --keyring "test" --key "quickstart" --ciphertext-file ./mysecret.txt.encrypted --plaintext-file ./mysecret.txt.decrypted`

## cloud dlp/data loss prevention
 - ***概要***
   - 画像やデータ識別API
   - 画像やデータを入れるとセキュリティ上の懸念があるデータを検知できる
 - ***参考***
   - [**inspecting image**](https://cloud.google.com/dlp/docs/inspecting-images)

## cloud iot core
 - ***概要***
   - iotのデバイスから送信されたデータをpub/subに投げ/受け取るもの
   - 様々なデータのやり取りを仲介する役割
   - <img src="https://cloud.google.com/iot/resources/cloud-iot-overview3.png?hl=ja">
 - ***mtqqのやり取りを行う***
   - **参考**
     - [quickstart](https://cloud.google.com/iot/docs/quickstart?hl=ja)
   - **registryとpub/subのtopicを作る**
     - `iot core`からレジストリ、トピックを作成する
     - 作成後`gcloud pubsub subscriptions create projects/${PROJECT_ID}/subscriptions/my-subscription --topic=projects/${PROJECT_ID}/topics/my-device-events`
   - **秘密鍵と公開鍵を作る**
     - `openssl req -x509 -newkey rsa:2048 -keyout rsa_private.pem -nodes -out rsa_cert.pem -subj "/CN=unused"`
   - **作成した公開鍵でdeviceを設定する**
   - **メッセージの発信**
     - `git clone https://github.com/googleapis/nodejs-iot.git` + `cd nodejs-iot/samples/mqtt_example`
     - `node cloudiot_mqtt_example_nodejs.js mqttDeviceDemo --projectId=${PROJECT_ID} --cloudRegion=us-central-1 --registryId=my-registry --deviceId=my-device --privateKeyFile=rsa_private.pem --serverCertFile=roots.pem --numMessages=25 --algorithm=RS256`
   - **メッセージの受信**
     - `gcloud pubsub subscriptions pull --auto-ack projects/${PROJECT_ID}/subscriptions/my-subscription`

## cloud dataprep
 - ***概要***
   - 可視化をできるEDAサービス

## cloud pub/sub
 - ***概要***
   - pub/subサービス
   - 順序は保証されない
 - ***ユースケース***
   - `dataflow`で集約し、`bigquery`に入れる
   - `dataflow`を`monitoring`に接続しmetricを作成、`monitoring/alert`でemailに通知するなど

## ai platform prediction
 - ***概要***
   - TODO

## cloud vision api
 - ***概要***
   - TODO
   - 実際に使ってみる

## cloud speech-to-text api
 - ***概要***
   - TODO
 - ***同期モード***
   - TODO
 - ***非同期モード***
   - TODO

## cloud natural language api
 - ***概要***
   - TODO
 

## trasnfer appliance
 - ***概要***
   - 大容量(PB級)のデータ転送サービス
   - fedexなどの運送業者をもちいてデータを物理で転送する

## storage transfer service
 - ***概要***
   - 大容量(TB級)のデータ転送サービス
   - オンラインで転送する

## olap
 - ***概要***
   - online analytical processing
   - `bigquery`が該当する

## oltp
 - ***概要***
   - online transaction processing
   - `cloud sql`, `cloud spanner`が該当する

## cloud spanner
 - ***概要***
   - 水平スケーリングできる

## 秘密鍵をstorageやinstanceに入れるべきでない
 - **概要**
   - セキュリティのプラクティス上、ストレージに秘密鍵等を保存すべきでない
   - Googleが考えるソリューションは実行サービスごとAPI経由で鍵を送る

## bigqueryの詳細な知識
 - ***セキュリティ***
   - **概要**
     - 雑なアクセス権限の管理を任されたとき、`cloud audit logs`から誰がどこにアクセスしたか確認できる
 - ***容量***
   - **概要**
     - 容量がローカルとbigquery上で変わっているとき、原因は文字コードに起因することが多い
 - ***スキーマが時々変更される状況***
   - **概要**
   - bigqueryは最初からこれらに対して`[Schema]`の`[Automatically detect]`を選択しているとハンドリングできる

