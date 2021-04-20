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

## GKEクラスタの検査

 - 設定ファイル
```console
$ kubectl config view
```
 - アクティブコンテキスト
```console
$ kubectl config current-context
```
 - すべてのクラスタのコンテキスト
```console
$ kubectl config get-contexts
```
 - ノード使用率の表示
```console
$ kubectl top nodes
```

## GKEをイントロスペクトする

 - 設定を記述したyamlを用意する
```console
$ kubectl apply -f ./new-nginx-pod.yaml
```

## Podのレプリカをスケール

```console
$ kubectl scale --replicas=3 deployment $deployment
```


