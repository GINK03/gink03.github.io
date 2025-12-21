---
layout: post
title: "google pagespeed insights"
date: 2025-12-21
excerpt: "google pagespeed insightsの使い方と活用法"
project: false
config: true
tag: ["google","chrome","pagespeed"]
comments: false
sort_key: "2025-12-21"
update_dates: ["2025-12-21"]
---

# google pagespeed insightsの使い方と活用法

## 概要
 - Google Pagespeed Insightsは、ウェブサイトのパフォーマンスを評価し、改善点を提案するツール
 - 一般公開のウェブサイト版と、GCPのPageSpeed Insights APIがある
   - ウェブサイト版: `https://pagespeed.web.dev/`
   - API版は自動計測や定期モニタリングに利用できる

## GCPのPageSpeed Insights API
 - `API とサービス` > `APIライブラリ` > `PageSpeed Insights API`を有効化
 - `認証情報` > `認証情報を作成` > `APIキー`でAPIキーを取得
 - 取得したAPIキーは環境変数やSecret Managerに保管する

## 代表的なメトリクス
 - `First Contentful Paint (FCP)`: ページを開いてから、「真っ白な画面」が終わり、何かが初めて表示されるまでの時間
 - `First Input Delay (FID)`: ユーザーが最初にボタンを押したりリンクをタップした時、ブラウザが実際に処理を開始するまでの待ち時間
 - `Largest Contentful Paint (LCP)`: 画面内で一番大きなメインの要素（ヒーロー画像や記事本文の巨大な見出しなど）が表示完了するまでの時間
 - `Cumulative Layout Shift (CLS)`: 読み込み中に画面がガクッとズレる量（視覚的な安定性）のスコア

## 計測手法
 - `Lab Data (Lighthouse)`: Googleのサーバー（またはあなたのPC）上で、仮想的に「遅いスマホ」や「遅い回線」を再現して実行
 - `User Data / Field Data (CrUX)`: 実際のユーザーが訪問した際のパフォーマンスデータを収集

## コード例

```python
import requests

# 設定
API_KEY = "YOUR_API_KEY"  # 取得したAPIキーを設定
TARGET_URL = "https://www.yahoo.co.jp/"
STRATEGY = "mobile"  # 'mobile' または 'desktop'

url = f"https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url={TARGET_URL}&key={API_KEY}&strategy={STRATEGY}"

print(f"Testing {TARGET_URL} ({STRATEGY})...")
response = requests.get(url)

if response.status_code != 200:
    print(f"Error: {response.status_code}")
    # return

data = response.json()

# 1. Lighthouse（ラボデータ）
lighthouse = data.get("lighthouseResult", {}).get("audits", {})

print(f"\n--- Lab Data (Simulation) ---")
print(f"FCP: {lighthouse.get('first-contentful-paint', {}).get('displayValue')}")
print(f"LCP: {lighthouse.get('largest-contentful-paint', {}).get('displayValue')}")
print(f"CLS: {lighthouse.get('cumulative-layout-shift', {}).get('displayValue')}")
# 代替指標: Total Blocking Time (TBT)
print(f"TBT (Lab's FID proxy): {lighthouse.get('total-blocking-time', {}).get('displayValue')}")

# 2. CrUX（フィールドデータ）
# FIDはここにしかありません
loading_exp = data.get("loadingExperience", {}).get("metrics", {})

if loading_exp:
    print(f"\n--- Field Data (Real Users) ---")
    # FCP
    print(f"FCP: {loading_exp.get('FIRST_CONTENTFUL_PAINT_MS', {}).get('percentile')} ms")
    # LCP
    print(f"LCP: {loading_exp.get('LARGEST_CONTENTFUL_PAINT_MS', {}).get('percentile')} ms")
    # CLS (単位なし、スコア)
    print(f"CLS: {loading_exp.get('CUMULATIVE_LAYOUT_SHIFT_SCORE', {}).get('percentile')}")
    
    # FID (First Input Delay)
    fid = loading_exp.get('FIRST_INPUT_DELAY_MS', {}).get('percentile')
    print(f"FID: {fid} ms" if fid else "FID: Data not available")

    # INP (Interaction to Next Paint) - FIDの後継指標
    inp = loading_exp.get('INTERACTION_TO_NEXT_PAINT', {}).get('percentile')
    print(f"INP: {inp} ms" if inp else "INP: Data not available")
else:
    print("\n--- Field Data ---")
    print("No real user data available for this URL.")
```
