---
layout: post
title: "oci oracle cloud infrastructure foundations"
date: 2021-05-14
excerpt: "oci oracle cloud infrastructure foundations認定"
learning: true
tag: ["cloud", "oci", "certification"]
comments: false
sort_key: "2022-05-14"
update_dates: ["2022-05-14"]
---

# oci oracle cloud infrastructure foundations認定

## 試験を受けてみて
 - 8時間のコースの内容のはずであるが、想像以上に難しかった
   - 各機能の詳細な部分を聞かれることが多い
   - 料金の管理方法や一部のプロダクトは無料枠の範囲をはみ出るので実感値を持つことが難しい

---

# 公式資料のメモ

## 公式資料
 - [Japanese: Understand OCI Foundations: 日本語](https://learn.oracle.com/ols/learning-path/japanese-understand-oci-foundations/35644/80239)

## クラウドコンピューティング
 - オンデマンドセルフサービス
 - 幅広いネットワークアクセス
 - リソースプーリング
 - 迅速な伸縮性
 - 従量制サービス
 
## 基本用語
### HA(高可用性)
 - ほぼすべての時間で利用可能に構成されたコンピューティング環境
### DR(ディズアスタリカバリ)
 - RPO
   - 目標復旧ポイント
 - RTO
   - 目標復旧時間
### フォルトトレランス
 - サービスの停止時間を最小に収める方法のこと
### スケーラビリティ
 - 垂直スケーリング
   - スケールアップ・ダウン
 - 水平スケーリング
   - スケールアウト・イン
 - 伸縮性
   - 素早くリソースを増減できること
### リージョン
 - 複数の可用性ドメインからなる地域
### 高可用性ドメイン(AD)
 - 同一リージョン内部で低レイテンシで結んだ複数の理論データセンター
### フォルトドメイン(FD)
 - AD内部で複数のリソースを結んだ理論データセンター
### 単一障害点の回避
 - FDの粒度で分けたり、ADの粒度で分けたりなど色々
### コンパートメント
 - 関連するリソースの集合
 - アクセスコントロールの単位でもある
 - 予算割当などができる
 - サブコンパートメントを持てる
### OCIコンピュート
 - ベアメタル
 - 専用仮想ホスト
 - 仮想マシン
 - コンテナエンジン
 - Functions
### Oracle Resource Manager
 - Terraformのマネージド・サービス
 - コンパートメントの内部で管理される
### OCI Storage
 - Block Volume
   - ハードディスクだがどこかリモートのシャーシに取り付けられている
   - コンピュートインスタンス用のストレージ
 - File Storage
   - 階層型のドキュメントの集合
   - NFSとSMBが標準
 - Object Storage
 - Archive Storage
### VNC
  - サブネット
    - プライベートに限定されない
    - リージョナルにできる
  - インターネットゲートウェイ
    - VNCとインターネットのパスを提供
  - パブリックOCIサービスとの通信
    - 基本的にインターネットを介さずに通信できる
### IAM
 - プリンシパル
   - コンピュートインスタンスを対象にプリンシパルを与えることができる(インスタンスプリンシパル)
 - コンパートメント
 - 認証
 - 認可
 - ポリシー構文
 
## OCI Database
### 選択肢
  - DBCS
    - インスタンスの種類
      - 仮想マシン
      - ベアメタル
      - RAC
    - OSの全部とデータベースソフトウェアをユーザ管理
  - ExaCS
    - OSの一部とデータベースソフトウェアをユーザ管理
  - Autonomous Database
    - データベースソフトウェアのみユーザ管理
### Autonomous Database
 - リレーショナル型
 - ドキュメント型
 - key value型
 - グラフ型
 - 専用のexadataインフラストラクチャにデプロイされる
### Autonomous JSON Database(AJD)
 - ドキュメント指向のデータベース
 - NoSQL
 - 低価格
 - 高可用性
### Oracle NoSQL Database
 - フルマネージドなNoSQL
 - カラムナー、キーバリュー、ドキュメント型などなど
 - 高パフォーマンス
 - 高信頼性
 - 安定した低レイテンシ
### MySQL Database Service(MDS)
 - HeatWaveというものを使うことでOLAP的な使い方をMySQLでできる
 
## 機械学習サービス
### Oracle AutoML
### Data Flow 
 - Apache Spark
### DataCatalog
 - 散在しているデータを理論統合してデータを見れる
 - Oracle DB, Exadata, MySQL, PostgreSQL, ObjectStorage(CSV, XML, など)
### Cloud SQL
 - Hadoop上のデータにOracleのSQLを実行
 

## モニタと通知
### モニタリング
 - メトリックを定義してアラームを通知することができる
### 通知
 - slack, email, function, sms, httpsなどをサポート
### ログ・アナリティクス
  - 潜在的な問題の検知
  - 異常の検出
  - 問題の修正

## OCIセキュリティ
### 種類
 - MFA
 - フェデレーション
   - okta的なもの
 - Vault
    - 鍵を集中管理する仕組み
 - Cloud Guard
   - 脆弱性を自動的に検知・通知する仕組み
 - Bastion
   - 期間限定付きのアクセスを提供するシステム
 - WAF(Webアプリケーション・ファイアウォール)
   - HTTP, HTTPSをルールに応じてフィルタ

## 支払い
 - Pay as You Go

## ハイブリットクラウド
 - VMware Cloud Foundationをユーザサイドに設定することでOCIと密な結合ができる 

