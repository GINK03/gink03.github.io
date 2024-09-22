---
layout: post
title: "aws ip address"
date: 2024-09-22
excerpt: "amazon ip addressの確認"
config: true
tag: ["aws", "ip address"]
sort_key: "2024-09-22"
update_dates: ["2024-09-22"]
comments: false
---

# aws ip addressの確認

## 概要
 - awsの各機能にはipアドレスが割り当てられている
 - IP一覧は`https://ip-ranges.amazonaws.com/ip-ranges.json` から取得できる

## 取得方法

```python
import pandas as pd
import requests

url = 'https://ip-ranges.amazonaws.com/ip-ranges.json'
data = requests.get(url).json()

df = pd.DataFrame(data['prefixes'])
df = df.query('service == "EC2"')
df = df.query('region.str.contains("^ap-northeast-", regex=True)')
df = df.sort_values(by=["region"], ascending=True)
df

"""
| ip_prefix        | region         | service   | network_border_group   |
|:-----------------|:---------------|:----------|:-----------------------|
| 52.196.0.0/14    | ap-northeast-1 | EC2       | ap-northeast-1         |
| 176.34.0.0/19    | ap-northeast-1 | EC2       | ap-northeast-1         |
| 99.77.139.0/24   | ap-northeast-1 | EC2       | ap-northeast-1         |
| 18.176.0.0/15    | ap-northeast-1 | EC2       | ap-northeast-1         |
| 99.150.48.0/21   | ap-northeast-1 | EC2       | ap-northeast-1         |
| 13.230.0.0/15    | ap-northeast-1 | EC2       | ap-northeast-1         |
| 176.34.32.0/19   | ap-northeast-1 | EC2       | ap-northeast-1         |
| 54.199.0.0/16    | ap-northeast-1 | EC2       | ap-northeast-1         |
| 52.95.255.48/28  | ap-northeast-1 | EC2       | ap-northeast-1         |
| 173.83.210.0/24  | ap-northeast-1 | EC2       | ap-northeast-1         |
...
"""
```
