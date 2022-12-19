---
layout: post
title: "twitter API v2"
date: 2022-12-19
excerpt: "twitter API v2の概要と使い方"
tags: ["api", "twitter api"]
config: true
comments: false
sort_key: "2022-12-19"
update_dates: ["2022-12-19"]
---

# twitter API v2の概要と使い方

## 概要
 - 2022年から新しく刷新されたtwitter API
 - 旧APIと認証方式が異なり`bear-token`から認証できる
   - twitter developerのappからtokenを発行できる

## ドキュメント
 - [https://developer.twitter.com/en/docs/twitter-api/](https://developer.twitter.com/en/docs/twitter-api/)

## データ構造の変化
 - `user`, `tweet`, `media`, `place`などの取得するための粒度があってそれを組み合わせて取得する
   - それぞれの粒度を設定するためにGET parameterに設定を行う

## 公式クエリ作成ツール
 - [https://developer.twitter.com/apitools/api](https://developer.twitter.com/apitools/api)
 - デバッグが難しいので公式ツールを使うのが堅実

## 公式のexample
 - [sampled-stream.py](https://github.com/twitterdev/Twitter-API-v2-sample-code/blob/main/Sampled-Stream/sampled-stream.py)
   - `requests`を`stream`モードで叩いている
   - [/tweepy/](/tweepy/)などのwrapperとなるソフトウェアを使うより確実
