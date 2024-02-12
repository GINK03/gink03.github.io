---
layout: post
title: "python yfinance"
date: 2024-02-12
excerpt: "python yfinanceの使い方"
project: false
config: true
tag: ["python", "yfinance"]
comments: false
sort_key: "2024-02-12"
update_dates: ["2024-02-12"]
---

# python yfinanceの使い方

## 概要
 - pythonで株価データを取得するためのライブラリ
 - アメリカの株価データを取得することができる

## インストール

```console
$ pip install yfinance
```

## 使い方

```python
import pandas as pd
import yfinance as yf

hists = []
for ticker in ["DIA", "VOO", "QQQ",]:
    obj = yf.Ticker(ticker)
    
    # get historical market data
    hist = obj.history(period="36mo")
    hist = hist.reset_index()
    hist["date"] = pd.to_datetime(hist["Date"]).dt.date
    hist["ticker"] = ticker
    hists.append(hist)

df = pd.concat(hists)

plt.figure(figsize=(30, 10))
ax = sns.lineplot(data=df, x="date", y="Close", hue="ticker")
ax.xaxis.set_major_locator(mdates.MonthLocator())
ax.set_xticklabels(ax.get_xticklabels(), rotation=90)
```

<div align="center">
  <img src="https://f004.backblazeb2.com/file/gimpeik/Images-2024/Screenshot+2024-02-12+at+11.00.51.png">
</div>

## 参考
 - [yfinance](https://pypi.org/project/yfinance/)
