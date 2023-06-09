---
layout: post
title: "json web tokens"
date: 2023-06-09
excerpt: "json web tokens(jwt)について"
tags: ["oauth", "jwt", "json web tokens"]
config: true
comments: false
sort_key: "2023-06-09"
update_dates: ["2023-06-09"]
---

# json web tokens(jwt)について

## 概要
 - header, payload, signatureの情報をそれぞれbase64でエンコードしたものを`.(ピリオド)`で結合したもの
   - header
     - 署名アルゴリズム
   - payload
     - ユーザについての情報
   - signature
     - headerとpayloadのハッシュ化したものを秘密鍵で署名したもの
     - headerとpayloadが受け取り側で改ざんされていないか確認できる
 - JWTの利点
   - 自己完結型
     - ユーザ情報を直接payloadから取得できる
   - 認証と認可に使用
     - OAuth2などで認証プロバイダにJWTを送り、それが正しいものかどうかを確認することができる

## JWTの調べ方
 - [jwt.io](https://jwt.io)にエンコードされたJWTを貼り付ければ情報を確認することができる
