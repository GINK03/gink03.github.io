---
layout: post
title: "python geoip2"
date: 2025-01-05
excerpt: "python geoip2"
config: true
tag: ["python", "geoip2"]
comments: false
sort_key: "2025-01-05"
update_dates: ["2025-01-05"]
---

# python geoip2

## 概要
 - IPアドレスから地理情報・ASN情報を取得するためのライブラリ
 - MaxMind社が提供するGeoLite2データベースを使用しているため、別途データベースのダウンロードが必要

## インストール

```console
$ pip install geoip2
```

## データベースのダウンロード
 - [github.com/P3TERX/GeoLite.mmdb](https://github.com/P3TERX/GeoLite.mmdb)

## 使い方

```python
import geoip2.database
from functools import lru_cache
import atexit

# データベースのパスを指定
CITY_DB_PATH = 'data/GeoLite2-City.mmdb'
ASN_DB_PATH = 'data/GeoLite2-ASN.mmdb'

# Readerをグローバルに保持
city_reader = geoip2.database.Reader(CITY_DB_PATH)
asn_reader = geoip2.database.Reader(ASN_DB_PATH)

# プログラム終了時にReaderを閉じる
def close_readers():
    city_reader.close()
    asn_reader.close()

atexit.register(close_readers)

@lru_cache(maxsize=500000)
def get_info_from_ip(ip_addr):
    try:
        # 住所情報の取得
        city_response = city_reader.city(ip_addr)
        country = city_response.country.name
        state = city_response.subdivisions.most_specific.name
        city = city_response.city.name
        latitude = city_response.location.latitude
        longitude = city_response.location.longitude

        # ASN情報の取得
        asn_response = asn_reader.asn(ip_addr)
        asn = asn_response.autonomous_system_number
        asn_org = asn_response.autonomous_system_organization

        # 結果の構築
        info = {
            'country': country,
            'state': state,
            'city': city,
            'latitude': latitude,
            'longitude': longitude,
            'asn': asn,
            'asn_org': asn_org
        }

        return info

    except geoip2.errors.AddressNotFoundError:
        # IPアドレスがデータベースに存在しない場合
        return None
    except Exception as e:
        # その他のエラー処理
        print(f"Error retrieving info for IP {ip_addr}: {e}")
        return None

get_info_from_ip('211.15.239.222')
"""
{'country': 'Japan',
 'state': 'Tokyo',
 'city': 'Musashino',
 'latitude': 35.7064,
 'longitude': 139.5633,
 'asn': 2516,
 'asn_org': 'KDDI CORPORATION'}
"""
```

## 参考
 - [github.com/maxmind/GeoIP2-python](https://github.com/maxmind/GeoIP2-python)
