---
layout: post
title: "meta marketing api"
date: 2025-11-22
excerpt: "meta marketing apiで広告インサイトや動画を取得したメモ"
config: true
comments: false
tag: ["meta", "facebook", "marketing api"]
sort_key: "2025-11-22"
update_dates: ["2025-11-22"]
---

# meta marketing apiのメモ

## 概要
 - meta marketing apiを使って広告インサイトや動画素材を取得したときの手順を整理する
 - アプリIDやアクセストークンや広告アカウントIDは全てダミー値や環境変数として扱う

## ライブラリのインストール
 - pythonの公式SDKとして`facebook-business`を使う
 - 併せて`pandas`と`requests`もインストールしておく

```console
$ pip install facebook-business pandas requests
```

## アクセストークンの取得
 - graph api explorerから`User Token`を発行し必要なpermissionを付与する
 - ここで得られるアクセストークンは1〜2時間程度でexpireする短期トークン
 - より長い期限(最大で半年程度)のトークンが必要な場合は`fb_exchange_token`を使ってlong lived tokenに交換する

```python
import requests

app_id = "<APP_ID>"
app_secret = "<APP_SECRET>"
short_lived_token = "<SHORT_LIVED_USER_ACCESS_TOKEN>"

url = (
    "https://graph.facebook.com/v21.0/oauth/access_token?"
    "grant_type=fb_exchange_token&"
    f"client_id={app_id}&"
    f"client_secret={app_secret}&"
    f"fb_exchange_token={short_lived_token}"
)

resp = requests.get(url)
print(resp.text)
```

## 準備
 - meta for developersでアプリを作成しmarketing apiに必要な権限を付与する
 - graph api explorerなどから一時的なユーザアクセストークンを発行し必要に応じてlong lived tokenに変換する
 - 実務では`APP_ID`や`APP_SECRET`や`ACCESS_TOKEN`を環境変数やsecret managerから読み込むようにする

```python
from facebook_business.api import FacebookAdsApi

app_id = "<APP_ID>"
app_secret = "<APP_SECRET>"
access_token = "<ACCESS_TOKEN>"

FacebookAdsApi.init(app_id, app_secret, access_token)
```

## 広告アカウントとキャンペーンの取得
 - 広告アカウントは`act_<AD_ACCOUNT_ID>`形式で指定する
 - キャンペーン一覧やインサイトは`AdAccount`オブジェクトから取得する

```python
from facebook_business.adobjects.adaccount import AdAccount

account = AdAccount("act_<AD_ACCOUNT_ID>")
campaigns = account.get_campaigns()
for c in campaigns:
    print(c["id"], c.get("name"))
```

## キャンペーンインサイトの取得
 - `get_insights`でキャンペーン単位の指標を取得できる
 - 期間指定に`date_preset`や`time_range`を使い`level="campaign"`などで粒度を変える

```python
from facebook_business.adobjects.adsinsights import AdsInsights
import pandas as pd

insights = account.get_insights(
    fields=[
        AdsInsights.Field.campaign_id,
        AdsInsights.Field.campaign_name,
        AdsInsights.Field.impressions,
        AdsInsights.Field.clicks,
        AdsInsights.Field.spend,
        AdsInsights.Field.date_start,
        AdsInsights.Field.date_stop,
    ],
    params={
        "date_preset": "maximum",
        "level": "campaign",
        "time_increment": 1,
    },
)

rows = []
for row in insights:
    rows.append(
        {
            "campaign_id": row["campaign_id"],
            "campaign_name": row.get("campaign_name"),
            "date_start": row["date_start"],
            "date_stop": row["date_stop"],
            "impressions": int(row["impressions"]),
            "clicks": int(row["clicks"]),
            "spend": float(row["spend"]),
        }
    )
df_campaign = pd.DataFrame(rows)
```

## 配信済み広告からクリエイティブと動画をひも付ける
 - どの動画クリエイティブが実際に配信されたかを知るために以下の順番でひも付ける
   - `AdAccount.get_insights(level="ad")`で配信実績のある広告IDを列挙
   - `Ad(ad_id)`から`creative_id`を取得
   - `AdCreative(creative_id)`から`video_id`を取得
   - `AdVideo(video_id)`から動画のメタ情報やダウンロードURLを取得

```python
from facebook_business.adobjects.ad import Ad
from facebook_business.adobjects.adcreative import AdCreative
from facebook_business.adobjects.advideo import AdVideo

ad_insights = account.get_insights(
    fields=["ad_id", "ad_name", "campaign_id", "campaign_name", "impressions"],
    params={"date_preset": "maximum", "level": "ad"},
)

served_ads = []
for row in ad_insights:
    if int(row["impressions"]) == 0:
        continue
    served_ads.append(
        {
            "ad_id": row["ad_id"],
            "ad_name": row.get("ad_name"),
            "campaign_id": row["campaign_id"],
            "campaign_name": row.get("campaign_name"),
            "impressions": int(row["impressions"]),
        }
    )
df_ads = pd.DataFrame(served_ads)
unique_ad_ids = sorted(df_ads["ad_id"].unique())
```

```python
ad_creatives = []
creative_ids = set()

for ad_id in unique_ad_ids:
    ad = Ad(ad_id).api_get(fields=["id", "name", "creative", "campaign_id"])
    creative = ad.get("creative")
    if not creative or "id" not in creative:
        continue
    cid = creative["id"]
    creative_ids.add(cid)
    ad_creatives.append(
        {
            "ad_id": ad_id,
            "creative_id": cid,
            "ad_name": ad.get("name"),
            "campaign_id": ad.get("campaign_id"),
        }
    )
df_ad_creative = pd.DataFrame(ad_creatives)
```

```python
creative_video_rows = []
video_ids = set()

for cid in creative_ids:
    creative = AdCreative(cid).api_get(
        fields=[
            "id",
            "name",
            "video_id",
            "object_story_spec",
        ]
    )

    video_id = None

    if creative.get("video_id"):
        video_id = creative["video_id"]
    else:
        oss = creative.get("object_story_spec") or {}
        video_data = oss.get("video_data") or {}
        if "video_id" in video_data:
            video_id = video_data["video_id"]
        else:
            link_data = oss.get("link_data") or {}
            video_id = link_data.get("video_id")

    if not video_id:
        continue

    video_ids.add(video_id)
    creative_video_rows.append(
        {
            "creative_id": cid,
            "video_id": video_id,
            "creative_name": creative.get("name"),
        }
    )

df_creative_video = pd.DataFrame(creative_video_rows)
```

```python
df_link = (
    df_ad_creative
    .merge(df_creative_video, on="creative_id", how="inner")
    .merge(
        df_ads[["ad_id", "campaign_id", "campaign_name", "impressions"]],
        on=["ad_id", "campaign_id"],
        how="left",
    )
)
```

## 動画ファイルのダウンロード
 - `AdVideo(video_id)`から`source`フィールドを取得し`requests`でダウンロードする
 - 実運用ではS3などオブジェクトストレージへの保存やレート制限を考慮する

```python
from pathlib import Path
import requests
from facebook_business.adobjects.advideo import AdVideo

video_id = "<VIDEO_ID>"
video = AdVideo(video_id).api_get(
    fields=["id", "title", "length", "permalink_url", "source"]
)

source_url = video.get("source")
out_dir = Path("video_downloads")
out_dir.mkdir(parents=True, exist_ok=True)
out_path = out_dir / f"{video_id}.mp4"

resp = requests.get(source_url, stream=True)
resp.raise_for_status()
with out_path.open("wb") as f:
    for chunk in resp.iter_content(chunk_size=1024 * 1024):
        if chunk:
            f.write(chunk)
```

## 権限まわりの注意
 - ページ権限や広告アカウントへのアクセス承認が適切に行われていないとcampaignやvideo情報を取得できない
 - metaビジネスマネージャで対象のビジネスと広告アカウントにアプリやユーザを招待し必要な権限を付与する
 - 権限が足りない場合はapiレスポンスにエラーコードが返るのでドキュメントを見ながら不足している権限を特定する
