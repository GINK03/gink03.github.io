---
layout: post
title: "pandas'datetime"
date: 2021-01-03
excerpt: "pandasのdatetime操作について"
project: false
kaggle: true
hide_from_post: true
tag: ["python", "pandas", "チートシート"]
comments: false
sort_key: "2022-03-26"
update_dates: ["2022-03-26"]
---

# pandasのdatetime操作について

## 概要
 - よく使う機能をチートシートとして記す
 - よく詰まるところ
   - `UTC`, `JST`がよくわからなくなる
   - 大量のレコードを高速にパースしたい
   - `week number`で`group by`したいが範囲として表記したい

---

## pd.to_datetime
 - 概要
   - `pd.to_datetime`はオプションによって速度が大きく異る  
   - 早い順に以下の通り
     1. `pd.to_datetime(c, format="%Y-%m-%d %H:%M:%S")`
     2. `pd.to_datetime(c, infer_datetime_format=True)`
     3. `pd.to_datetime(c)`

### 参考処理時間(ツイッターのデータ)

```python
df["tweet_date"] = pd.to_datetime(df["created_at"],  format="%Y-%m-%d %H:%M:%S JST") ## 11.5s
df["tweet_date"] = pd.to_datetime(df["created_at"],  infer_datetime_format=True) # 4min 12s = 252s
df["tweet_date"] = pd.to_datetime(df["created_at"]) # 3min 37s
```

### UTC時間(+0000)にオフセットする
 - `Tue Oct 19 04:02:23 +0000 2021`のようなフォーマットのときはUTC時間なので日本時間に合わせるためにオフセットが必要である

```python
pd.to_datetime(df["created_at"], format="%a %b %d %H:%M:%S +0000 %Y") + pd.DateOffset(hours=9)
```

---

## Series.dt.strftime
 - 概要
   - 時間を文字列に変換する

```python
df["date"].dt.strftime("%Y-%m-%d") # "年-月-日"
```

---

## timestampをUTC -> Asia/Tokyoにする

```python
df["ts"] = pd.DatetimeIndex(df["ts"]).tz_convert("Asia/Tokyo")
```

---

## `tz aware`のデータを`tz native`にする
 - `tz aware`のデータと`tz native`のデータは比較することができないので、どちらかをどちらかに寄せる必要がある

```python
df["tz_native"] = df["tz_aware"].dt.tz_localize(None)
```

---

### Series.dt.floor 
 - 概要
   - 時間情報を荒い粒度に変換する
   - 変換は切り捨て
 - Google Colab
   - [pandas-dt-floor-example](https://colab.research.google.com/drive/1JGGaV1wDt-7w2bwDAQEjwus22ns7ZB_B?usp=sharing)

```python
df = pd.DataFrame()

df["day"] = [ datetime.datetime.now() - datetime.timedelta(days=i) for i in range(100) ]
df["floored"] = df["day"].dt.floor("7D") # 一週間区切りにする

"""
day	floored
0	2022-03-26 07:24:41.450533	2022-03-24
1	2022-03-25 07:24:41.450553	2022-03-24
2	2022-03-24 07:24:41.450558	2022-03-24
3	2022-03-23 07:24:41.450561	2022-03-17
4	2022-03-22 07:24:41.450563	2022-03-17
5	2022-03-21 07:24:41.450567	2022-03-17
6	2022-03-20 07:24:41.450570	2022-03-17
7	2022-03-19 07:24:41.450573	2022-03-17
8	2022-03-18 07:24:41.450575	2022-03-17
9	2022-03-17 07:24:41.450578	2022-03-17
10	2022-03-16 07:24:41.450581	2022-03-10
...
"""
```

---

### Series.dt.round
 - 概要
   - 時間の丸め込み
   - 四捨五入的に振る舞う

```python
# 15分の粒度で丸め込む場合
df["round_time"] = pd.to_datetime(df["date"]).dt.round('15min')
```

---

### WeekNumber(week number)を範囲で文字表記する
 - 概要
   - week numberはその年の何番目の週かをカウントする指標
   - 週毎のKPIを出したいときなどに便利
   - その年のある週を指し示すフォーマットは`%Y_%W`
   - 復元に必要な情報は`%Y_%W%w`
 - Google Colab
   - [pandas-weeknumber-day-range](https://colab.research.google.com/drive/1lXbSN08QQ9GXjuhUQC0jtOj_YuKszNwc?usp=sharing)

**ある週の範囲を文字列表記する**

```python
import pandas as pd
import datetime

df = pd.DataFrame()
dt = datetime.datetime.strptime("2100-01-01", "%Y-%m-%d")
df["datetime"] = [dt + datetime.timedelta(days=i) for i in range(1, 366)]
df["YYYY_W"] = df["datetime"].dt.strftime("%Y_%W")

df["range"] = pd.to_datetime(df["YYYY_W"] + "1", format="%Y_%W%w").dt.strftime("%Y-%m-%d") + " ~ " + pd.to_datetime(df["YYYY_W"] + "0", format="%Y_%W%w").dt.strftime("%Y-%m-%d")

"""
index	datetime	YYYY_W	range
0	2100-01-02 00:00:00	2100_00	2099-12-28 ~ 2100-01-03
1	2100-01-03 00:00:00	2100_00	2099-12-28 ~ 2100-01-03
2	2100-01-04 00:00:00	2100_01	2100-01-04 ~ 2100-01-10
3	2100-01-05 00:00:00	2100_01	2100-01-04 ~ 2100-01-10
4	2100-01-06 00:00:00	2100_01	2100-01-04 ~ 2100-01-10
5	2100-01-07 00:00:00	2100_01	2100-01-04 ~ 2100-01-10
6	2100-01-08 00:00:00	2100_01	2100-01-04 ~ 2100-01-10
7	2100-01-09 00:00:00	2100_01	2100-01-04 ~ 2100-01-10
8	2100-01-10 00:00:00	2100_01	2100-01-04 ~ 2100-01-10
9	2100-01-11 00:00:00	2100_02	2100-01-11 ~ 2100-01-17
"""
```