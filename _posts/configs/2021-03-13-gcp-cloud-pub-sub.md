---
layout: post
title: "gcp cloud pub/sub"
date: 2021-03-13
excerpt: "gcp cloud pub/subについて"
tags: ["cloud pub/sub", "gcp"]
config: true
comments: false
sort_key: "2021-06-19"
update_dates: ["2021-06-19"]
---

# gcp cloud pub/subについて

## 概要
 - グローバルメッセージングサービス
 - キューイングサービスのように使えるので、リアルタイムに動かすのがきつい場合に、非同期を許容することで動作させることができる
   - Cloud Functions, Cloud Runとの連携も可能である

## よく使うコマンド

### topicの作成

```console
$ gcloud pubsub topics create ${TOPIC}
```

### メッセージの送信

```console
$ gcloud pubsub topics publish ${TOPIC} --message "hello"
```

### サブスクリプションの作成

```console
$ gcloud pubsub subscriptions create --topic ${TOPIC} ${SUBSCRIPT}
```

### メッセージのpull

```console
$ gcloud pubsub subscriptions pull --auto-ack ${SUBSCRIPT}
```

---

## ローカルエミュレータ

### 起動
```console
$ gcloud beta emulators pubsub start --project=<starry-lattice-256603>
```
 - `--project`は実際に存在するプロジェクト名である必要がある

### 環境変数の設定
```console
$ $(gcloud beta emulators pubsub env-init)
```

---

## pythonでの使用例

### publisher

```python
from google.cloud import pubsub_v1

project_id = "starry-lattice-256603"
topic_id = "test-topic"

publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path(project_id, topic_id)

for n in range(1, 10):
    data_str = f"Message number {n}"
    # Data must be a bytestring
    data = data_str.encode("utf-8")
    # When you publish a message, the client returns a future.
    future = publisher.publish(topic_path, data)
    print(future.result())

print(f"Published messages to {topic_path}.")
```

### subscriber

```python
from concurrent.futures import TimeoutError
from google.cloud import pubsub_v1

# TODO(developer)
project_id = "starry-lattice-256603"
subscription_id = "test-subscriber"
# Number of seconds the subscriber should listen for messages
timeout = 5.0

subscriber = pubsub_v1.SubscriberClient()
subscription_path = subscriber.subscription_path(project_id, subscription_id)

def callback(message: pubsub_v1.subscriber.message.Message) -> None:
    print(f"Received {message}.")
    message.ack()

streaming_pull_future = subscriber.subscribe(subscription_path, callback=callback)
print(f"Listening for messages on {subscription_path}..\n")

# Wrap subscriber in a 'with' block to automatically call close() when done.
with subscriber:
    try:
        streaming_pull_future.result()
    except TimeoutError:
        streaming_pull_future.cancel()  # Trigger the shutdown.
        streaming_pull_future.result()  # Block until the shutdown is complete.
```

---

## Cloud Pub/SubからCloud Functionsをトリガーする

### 概要
 - Subscription側でメッセージを受け取ったらFunctionsを起動することが可能
 - CUIでもデプロイできるが、Pub/Subの管理画面から、Functionsをトリガーすることもできる
   - CUIでうまくいかなった際に、WebUIから操作したところ、トリガーできた

### 手順
 - WebUI
   - Pub/Subの管理画面
   - トピックを選択
   - Functionsに紐づけたいトピックのハンバーガーボタンから、`Cloud Functionをトリガー`を選択し、functionsを初期化

---

## 参考
 - [エミュレータを使用したローカルでのアプリのテスト/GoogleCloud](https://cloud.google.com/pubsub/docs/emulator)
 - [How to use Google Pub/Sub emulator locally to test Google Pub/Sub on Apple Silicon Chip (M1)](https://medium.com/devops-techable/how-to-use-google-pub-sub-emulator-locally-to-test-google-pub-sub-on-apple-silicon-chip-m1-5770a806a5c8)
 - [クライアント ライブラリを使用して Pub/Sub でメッセージをパブリッシュおよび受信する/GoogleCloud](https://cloud.google.com/pubsub/docs/publish-receive-messages-client-library)
