---
layout: post
title: "google cloud professional machine learning engineer"
date: 2021-03-19
excerpt: "google cloud professional machine learning engineer認定"
learning: true
tag: ["cloud"]
comments: false
---

# google cloud professional machine learning engineer認定

## 参考ドキュメント
 - [公式の説明](https://cloud.google.com/certification/machine-learning-engineer)
 - [Google Cloud Professional Machine Learning Engineer Exam（BETA）まで20日](https://towardsdatascience.com/20-days-to-google-cloud-professional-machine-learning-engineer-exam-beta-b48909499942)
   - ML問題のフレーミング
	 - 顧客に最適な問題定義
	 - 慎重な問題の読み込み
   - MLソリューションアーキテクチャ
	 - GPUとTPUの違い
   - データの準備と処理
	 - TFrecordsの役割
   - モデルの開発
	 - BQML
	 - SparkMLlib
	 - AutoML
	 - ML API
	 - AI Platform
   - MLパイプラインの自動化とオーケストレーション
	 - kubeflowパイプライン
 - [Google Professional Machine Learning Engineer Exam：何を期待するか](https://towardsdatascience.com/google-professional-machine-learning-engineer-exam-what-to-expect-f1188e356046)
 - [How I cracked the GCP Professional ML Engineer certification in 8 days!](https://ml-rafiqhasan.medium.com/how-i-cracked-the-gcp-professional-ml-engineer-certification-in-8-days-f341cf0bc5a0)

## tensorflowの分散トレーニング
 - TPU > GPU > CPU
 - `synronouse training`
   - different slices of input data in sync
   - aggregationg gradients at each step
 - `async training`
   - all worker are independent 
 - `mirrored strategy`
   - sync 
   - GPUs on one machine
   - creates one replica per GPU
   - all variable are mirrored across all replicas
 - `NVIDIA NCCL`
   - all-reduce implementation
 - `parameter server strategy`
   - parameter server 
 - `central storage strategy`
   - sync
   - not mirred
 - `tpu strategy`
   - mirred
   - all-reduce

## TPUでのトレーニング
 - [公式ドキュメント](https://www.tensorflow.org/guide/tpu)

## ai platformでの分散トレーニング
 - master, worker, paramter serverのcontainerでトレーニングする
 - sklearn, xgboost等はサポートされない
 - ベイス最適化がある

## 説明可能なAI
 - アルゴリズム
   - Integrated Gradients
   - XAI
   - Sampled Shaplely
 - AutoML tableもサポート

## kubeflowパイプライン

## 精度
 - 再現率
 - 適合性
 - F1
 - AUCROC > AUCRP(クラスバランス不変)

