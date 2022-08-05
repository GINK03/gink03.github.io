---
layout: post
title: "instagram api"
date: 2017-09-04
excerpt: "Instagram Api"
tag: ["instagram"]
config: true
sort_key: "2017-09-04"
comments: false
update_dates: ["2022-08-05", "2017-09-04"]
---

# Instagram API (2022/08)

## Instagram APIでできること
 - 2022/08
   - 申請者自身のアカウントの管理と情報の取得がメインで、他のユーザの情報の取得は想定されていない
   - ユーザ自信が許可し、ユーザIDをAPIの実行者に共有した場合は情報の取得ができる
 - 2017/09
   - Instagram APIは制限が厳しく、審査が通っていない状態では、Sandboxモードと呼ばれる自分のアカウント+10ユーザのポストしか見れない  
   - これは、Instagram APIが自社のエコシステムに全て誘導するため、サードパーティの製品のクライアントの登場を防ぐという意味があるらしい  

## APIの種類 
 - `api.instagram.com`
   - アクセストークンの取得
 - `graph.instagram.com`
   - Instagramユーザープロフィールとメディアの取得用

## アクセストークン取得まで流れ(2022/08)
 - 流れ
   - Facebookでアプリを作成
   - 身分証明書付きで申請
   - OAuthにより一時的な`access_token`を発行
   - `access_token`とFacebookアプリのID, secretが揃うことで初めてアクセス可能
 - 参考
   - [Instagram基本表示API](https://developers.facebook.com/docs/instagram-basic-display-api)

## 使用原則
 - 概要
   - 審査を通すためには原則にしたがっている必要がある
 - 原則
   - 個人ユーザーが、自身のコンテンツをサードパーティーのアプリに共有することを助けるアプリ。
   - ブランドおよび広告主が、広告の受け手やメディアの著作権について理解し、管理することを助けるアプリ。
   - 放送局や出版社が、コンテンツを発見し、デジタル利用権を取得し、適切な権利帰属関係でシェアすることを助けるアプリ。


## SandBoxモード(2017/09にはあったが現在はななそう)
 - Sandboxモードは機能に様々な制約が課された状態で、自分のタイムラインと他許可したユーザ10人までの情報が見ることができる  

<p align="center">
  <img width="550px" src="https://user-images.githubusercontent.com/4949982/30026455-f66beabc-91b7-11e7-8ef6-5fd5ab7f156b.png">
</p>


