---
layout: post
title: "continuous evaluation"
date: 2021-03-23
excerpt: "継続評価(continuous evaluation)について"
computer_science: true
hide_from_post: true
tag: ["継続評価", "continuous evaluation"]
comments: false
---

# 継続評価(continuous evaluation)について

## 機械学習の例
 - ***GCP***
   - **仕組み**
	 - 良くした内容をサンプリングしてbigqueryに保存する
	 - data labeling serviceにより、ラベンリングを行う
	 - 定期的な評価ジョブが走り、KPIが確認できる
