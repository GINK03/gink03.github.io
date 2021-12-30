---
layout: post
title: "kubernetes"
date: 2021-04-20
excerpt: "kubernetesについて"
computer_science: true
hide_from_post: true
tag: ["runtime", "cloud", "kubernetes", "k8s", "kubectl"]
comments: false
---

# kubernetesについて

## GCP上のクラスタ

### クラスタの作成

```console
$ gcloud container clusters create $cluster-name --num-nodes=1
```
 - 10分弱操作に時間がかかる

### ノードサイズの変更

```console
$ gcloud container clusters resize $cluster-name --num-nodes $num-node
```

### GKEクラスタに接続する

```console
$ gcloud container clusters get-credentials $cluster-name
```
 - 実行すると`.kube/config`が作成される

## ローカルでのクラスタ
 - [minikube](/minikube/)
 - microk8s

## kubectl概要
 - kubernetesクラスタを操作するツール

## kubectlインストール

**linux**
```console
$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
$ chmod +x kubectl
```

## クラスタへコンテナのデプロイ

```console
$ kubectl create deployment <deployment-name> --image=<container-name or path>
```

## デプロイしたIPやポートなどの状態を確認する

```console
$ kubectl get services <deployment-name>
```

## クラスタのポートとローカルをポートフォワーディング

```console
$ kubectl port-forward service/<deployment-name> <local-port>:<remote-port>
```

## podのリストを表示

```console
$ kubectl get pods
```

## podの標準出力を確認する

```console
$ kubectl logs <pod-name>
```

## podのポート公開

```console
$ kubectl expose pod <pod-name> --port 80 --type LoadBalancer
```

## nodeportの公開

```console
$ kubectl expose deployment <deployment-name> --target-port=8080 --type=NodePort
```

## GKEをイントロスペクトする

**設定を記述したyamlを用意し、適応**
```console
$ kubectl apply -f ./<yaml file>
```

**namespaceを指定してapply**
```console
$ kubectl apply -f ./<yaml file>.yaml --namespace=<namespace>
```
 - yamlの`metadata`に`namespace: $production`を設定してもいい

## デプロイメントを作成する

```console
$ kubectl create -f ./<yaml file> --save-config
```
 - applyとcreateの違いはすでにあるデプロイメントを利用するか作成するか

## Podのレプリカをスケール

```console
$ kubectl scale --replicas=3 deployment <deployment>
```

## デプロイメントのオートスケール

```console
$ kubectl autoscale deployment <deployment> --max 4 --min 1 --cpu-percent 1
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
apiVersion: batch/v1
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
 - `kubectl get pods`して`kubectl logs <pod-name>`で結果を確認できる
	

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
