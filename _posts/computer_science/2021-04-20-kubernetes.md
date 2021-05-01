---
layout: post
title: "kubernetes"
date: 2021-04-20
excerpt: "kubernetesについて"
computer_science: true
hide_from_post: true
tag: ["runtime", "cloud"]
comments: false
---

# kubernetesについて

## クラスタの作成

```console
$ gcloud container clusters create $cluster-name --num-nodes=1
```
 - 10分じゃく操作に時間がかかる

## ノードサイズの変更

```console
$ gcloud container clusters resize $cluster-name --num-nodes $num-node
```

## GKEクラスタに接続する

```console
$ gcloud container clusters get-credentials $cluster-name
```
 - 実行すると`.kube/config`が作成される

## コンテナのデプロイ

```console
$ kubectl create deployment $cluster-name --image=gcr.io/${PROJECT_ID}/$container-name
```

## podのポート公開

```console
$ kubectl expose pod $my-pod --port 80 --type LoadBalancer
```

## deploymentのnodeportの公開

```console
$ kubectl expose deployment $web --target-port=8080 --type=NodePort
```

## GKEクラスタの検査

**設定ファイル**
```console
$ kubectl config view
```

**アクティブコンテキスト**
```console
$ kubectl config current-context
```

**すべてのクラスタのコンテキスト**
```console
$ kubectl config get-contexts
```

**ノード使用率の表示**
```console
$ kubectl top nodes
```

**horizontal pod autoscalerを調べる**
```console
$ kubectl get hpa
```

## GKEをイントロスペクトする

**設定を記述したyamlを用意する**
```console
$ kubectl apply -f ./$new-nginx-pod.yaml
```

**namespaceを指定してapply**
```console
$ kubectl apply -f ./my-pod.yaml --namespace=$production
```
 - yamlの`metadata`に`namespace: $production`を設定してもいい

## デプロイメントを作成する

```console
$ kubectl create -f $web.yaml --save-config
```

## Podのレプリカをスケール

```console
$ kubectl scale --replicas=3 deployment $deployment
```

## デプロイメントのオートスケール

```console
$ kubectl autoscale deployment $web --max 4 --min 1 --cpu-percent 1
```

## デプロイメントをpushすることなく適応する場合

```console
$ kubectl rollout pause deployment 
```

## rollbindingする

***admin権限をbinding***
```console
$ kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $USERNAME_EMAIL
```

# yamlのパラメータの設定
 - `parallelism`
   - ジョブで実行する最大のPOD数
 - `completions`
   - 一定数のポッドが正常に終了すると完了するジョブ
 - `backofflimit`
   - 指数バックオフで何回チャレンジするか

# 設定テンプレート

## 小数点2000桁を計算する

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  # Unique key of the Job instance
  name: example-job
spec:
  template:
    metadata:
      name: example-job
    spec:
      containers:
      - name: pi
        image: perl
        command: ["perl"]
        args: ["-Mbignum=bpi", "-wle", "print bpi(2000)"]
      # Do not restart containers after they exit
      restartPolicy: Never
```

## cron job

```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: hello
spec:
  schedule: "*/1 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox
            args:
            - /bin/sh
            - -c
            - date; echo "Hello, World!"
          restartPolicy: OnFailure
```
 - 毎分`echo`する
	

## hello-app

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
spec:
  replicas: 1
  selector:
    matchLabels:
      run: web
  template:
    metadata:
      labels:
        run: web
    spec:
      containers:
      - image: gcr.io/google-samples/hello-app:1.0
        name: web
        ports:
        - containerPort: 8080
          protocol: TCP

```

## namespaceを作成

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```
