---
layout: post
title: "Jupyter vibe analytics"
date: 2026-02-22
excerpt: "Jupyterでvibe analyticsを進める手順"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2026-02-22"
update_dates: ["2026-02-22"]
---

# Jupyter vibe analytics

## 概要
 - vibe analyticsをJupyterで行う
 - いくつかの進め方がある
   - `.ipynb`ファイルを直接編集する方法
   - Jupytextを用いて `.py` ファイルを編集する方法

## `.ipynb` ファイルを直接編集する方法
 1. Jupyter Notebookでいったん保存する
 2. 対象の `.ipynb` ファイルをAIエージェントに渡し、対話を通じて新規セルに分析用コードを追加する
 3. ブラウザをリロードして編集内容を読み込む
   - リロード前に上書き保存は行わない
 4. 作成されたセルを実行して分析結果を確認し保存
 5. 必要に応じて、再度AIエージェントに結果を参照させて次のアクションを決める

