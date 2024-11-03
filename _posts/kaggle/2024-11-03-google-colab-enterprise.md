---
layout: post
title: "google colab enterprise"
date: 2024-11-03
excerpt: "google colab enterpriseの使い方"
tags: ["jupyter", "google colab", "colab"]
kaggle: true
comments: false
sort_key: "2024-11-03"
update_dates: ["2024-11-03"]
---

# google colab enterpriseの使い方

## 概要
 - google cloudの機能のvertex aiの中にgoogle colab enterpriseがある
 - terminalも使用可能なので任意のソフトウェアをインストール可能

## google colaboratoryとcolab enterpriseとの違い

|                  |                **Google Colaboratory** |               **Colab Enterprise** |
|------------------|---------------------------------------:|-----------------------------------:|
| 主な用途         | 個人ユーザーや小規模なプロジェクト向け | 企業や組織の大規模プロジェクト向け |
| 利用料金         |       無料（Pro/Pro+の有料プランあり） |     Google Cloudの料金体系に基づく |
| アクセス管理     |             個別のアカウントでアクセス |                        IAMでの管理 |
| Google Cloud連携 |           BigQuery等との直接連携はなし |         Google Cloudサービスと統合 |
| 計算リソース     |                       無料版は制限あり |     必要に応じて拡張可能なリソース |

## 用語
 - ランタイム
   - ノートブックの実行環境で実行時に任意に選択・作成
 - ラインチムテンプレート
   - ノートブック実行時に使用するラインチムの設定を事前に定義(インスタンスタイプ、GPU、TPU、メモリ、ディスク容量など)
   - アイドル状態でのシャットダウン時間も設定可能

## 参考
 - [Colab Enterprise を解説 - zenn.dev](https://zenn.dev/cloud_ace/articles/1085659bb87dfe)
