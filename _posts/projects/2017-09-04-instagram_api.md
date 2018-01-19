---
layout: post
title:  "instagram api"
date:   2017-09-04
excerpt: "Instagram Api"
project: true
tag:
- Instagram API
comments: false
---

# Instagram API (2017/09)

## Instagram APIでできること
Instagram APIは制限が厳しく、審査が通っていない状態では、Sandboxモードと呼ばれる自分のアカウント+10ユーザのポストしか見れない  
これは、Instagram APIが自社のエコシステムに全て誘導するため、サードパーティの製品のクライアントの登場を防ぐという意味があるらしい  

審査を通すと、この辺の機能制限はなくなるが、審査を通すためには以下の原則に乗っ取っている必要がある
```console
- １ 個人ユーザーが、自身のコンテンツをサードパーティーのアプリに共有することを助けるアプリ。
- ２ ブランドおよび広告主が、広告の受け手やメディアの著作権について理解し、管理することを助けるアプリ。
- ３ 放送局や出版社が、コンテンツを発見し、デジタル利用権を取得し、適切な権利帰属関係でシェアすることを助けるアプリ。
```

広告の文脈で使用するには、2が必要か

また、アプリを作成した際に、アプリの紹介などが必要になる  

一般的に、[険しい道](http://socialmedia-marketing.argyle.jp/instagram/instagramapi/)と言われている。

## SandBoxモード
Sandboxモードは機能に様々な制約が課された状態で、自分のタイムラインと他許可したユーザ10人までの情報が見ることができる  

<p align="center">
  <img width="550px" src="https://user-images.githubusercontent.com/4949982/30026455-f66beabc-91b7-11e7-8ef6-5fd5ab7f156b.png">
</p>
この画面から入っていく  

RedirectURLがなぜ必要なのか、全く理解できていないが、何か必要なのだろう  
自分のホームページの適当なURLを切り出し、貼り付けることで認証を通す  
<p align="center">
  <img width="550px" src="https://user-images.githubusercontent.com/4949982/30026696-fabb7cbc-91b8-11e7-969a-32034680524b.png">
</p>

次に、以下のURLをブラウザで参照して、認証を通す必要がある
```console
https://api.instagram.com/oauth/authorize/?client_id={CLIENT_ID}&redirect_uri={REDIRECT_URI}&response_type=token&scope=public_content
```

この時、REDIRECT_URIに飛ばされるが必要があるかわからない
例えば、つぎのような例で、データを取得することができる
```console
$ curl https://api.instagram.com/v1/users/self/?access_token=5988600286.8a52673.bb14acca3a4946ca8a***********
{"data": 
  { "id": "5988600286", 
    "username": "giashi", 
    "profile_picture": "https://instagram.fada1-7.fna.fbcdn.net/t51.2885-19/11906329_960233084022564_1448528159_a.jpg",
    "full_name": "GK", 
    "bio": "", 
    "website": "", 
    "is_business": false, 
    "counts": {"media": 0, "follows": 6, "followed_by": 0}
  }, 
  "meta": {"code": 200}
}
```

## ビジネスとしてこのAPIは使用していいのか
大丈夫らしいですが、審査を通す必要があります  

多くの文献では、審査を通すのは一般的に難しいとされています  
