---
layout: post
title:  "AWS public"
date:   2017-04-07
excerpt: "自分向け資料"
project: false
config: true
tag:
- aws
comments: false
---

# AWSの社外アクセス
　原則として、社外からのAWSのアクセスはできない。    
　IPに穴を開けて利用を可能にする。   
　一度、Private Networkで作成したインスタンスを再び外部から開放するのはできないので、必ずインスタンス作成時に対応する必要がある。   

## プライベート->パブリック
　プライベートのインスタンスを選択して、[アクション]->[同様のものを作成]を選択。  
![](https://cloud.githubusercontent.com/assets/4949982/24785772/77037b50-1b97-11e7-9b22-5726d4f292bb.png)

![](https://cloud.githubusercontent.com/assets/4949982/24785776/7f6e5d64-1b97-11e7-90d2-b1eaae169589.png)

## インバウンドルールの追加
![](https://cloud.githubusercontent.com/assets/4949982/24786175/425abcd0-1b9a-11e7-92ea-524431eaf571.png)
