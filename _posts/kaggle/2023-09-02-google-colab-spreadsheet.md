---
layout: post
title: "google colabでgoogle spreadsheets"
date: 2023-09-02
excerpt: "google colabでgoogle spreadsheetsの使い方"
tags: ["jupyter", "google colab", "colab", "google spreadsheets"]
kaggle: true
comments: false
sort_key: "2023-09-03"
update_dates: ["2023-09-03"]
---

# google colabでgoogle spreadsheetsの使い方

## 概要
 - [/gspread/](/gspread/)というライブラリを利用することでスプレッドシートへの読み書きを行える

## 具体例

```python
import gspread
from google.auth import default

creds, _ = default()
GC = gspread.authorize(creds)

def load_gss(worksheet: str) -> pd.DataFrame:
  wb = GC.open_by_url('https://docs.google.com/spreadsheets/d/*************************-HmrNNaIAs7vXeTP-eVI/edit#gid=969528449')
  a = pd.DataFrame(wb.worksheet('投稿文').get_all_values())
  a.columns = a.iloc[0].tolist()
  a = a[1:]
  return a

def save_gss(worksheet: str, df: pd.DataFrame):
  wb = GC.open_by_url('https://docs.google.com/spreadsheets/d/********************************-HmrNNaIAs7vXeTP-eVI/edit#gid=969528449')
  wb.values_update("投稿文",
                params={'valueInputOption': 'USER_ENTERED'},
                body={"values":  np.vstack([df.columns, df.values]).tolist()})
```

