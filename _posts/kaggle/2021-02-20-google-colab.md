---
layout: post
title: "google colab"
date: 2021-02-20
excerpt: "google colabの使い方"
tags: ["jupyter", "google colab", "colab"]
kaggle: true
comments: false
sort_key: "2022-04-05"
update_dates: ["2022-04-05","2022-04-05","2021-05-30","2021-05-30"]
---

# google colabの使い方

## 概要
 - google製のjupyter notebook
   - 微妙なところに差分がある 
 - colabを仕事で使うには、colabがセキュリティ要件をクリアしているか確認する必要がある
   - `Google Workspace`と`GCP`がガイドラインに従って運用されている組織であれば適合しやすい

## 便利な点
 - サーバレスで自分でコンピューティング資源を確保しなくて良い
 - 共有が楽であり、実際に行った実験等のシェアに便利
 - GPUが無料で使える

## 注意すべき点
 - terminalが無料版では使えない
   - 有料のproでは使える
 - 数分でセッションがリセットされる
   - セッションがリセットされると`apt-get`, `pip`でインストールしたものも消える
   - プロ版は12時間以上持つらしい
 - HTML関数を使ったcssのオーバーライドは動作しない
   - iframeで情報をやり取りしているためらしい
 - pandasのquery関数がengineを指定しないと動作しない

## pandasのquery関数にデフォルトで`engine="python"`を与える

```python
%pip install pandas -U 2>&1 > /dev/nul 
import pandas as pd
import numpy as np
from functools import partialmethod
pd.DataFrame.query = partialmethod(pd.DataFrame.query, engine="python")
```

## Google Driveのマウント

**マウント**
```python
from google.colab import drive
drive.mount('/content/drive')
```

**明示的に同期する**
```python
drive.flush_and_unmount()
print('All changes made in this colab session should now be visible in Drive.')
```

**google driveにパッケージをインストールする**
```python
!pip install ${PKG} -t "/content/drive/MyDrive/colab/libs" 2>&1 > /dev/null
```

## BigQueryにクエリを送り、pandas dataframeを取得する
 - 手法
   1. `from google.colab import auth`モジュールで認証を通す
   2. プロジェクト名(課金先)と取得したデータの格納先変数をセットする

**1. 認証を通す**  
```python
from google.colab import auth
from google.cloud import bigquery
from google.colab import data_table

project = "<your-project>"
location = "asia-northeast1"
client = bigquery.Client(project=project, location=location)
data_table.enable_dataframe_formatter()
auth.authenticate_user()
```

**2. クエリを実行し、dfというpandasのdataframeに結果を格納**  
```python
df = client.query('''
SELECT
  user_id,
  user.ua as ua,
  event.name as event_name,
  event.payload.push_notification_status as push_notification_status,
  user.device.category as device_cat,
  content.page.type as page_type,
  ts.utc.raw as ts_utc,
  ts.jst.raw as ts_jst,
FROM
  `<your-project>.<your-bucket>.<table>`
WHERE
  DATE(ts.jst.raw) = "2022-12-01" 
ORDER BY
  user_id,
  ts.jst.raw
''').to_dataframe()
df
```

## Colabで出力したファイルのダウンロード
 - 出力したファイルはcolabのサーバサイドに保存されるのでGoogle Driveでは見えない
 - 専用の関数でダウンロードする

```python
df.to_csv("filename.csv")
from google.colab import files
files.download("filename.csv") # ダウンロード
```

## GPUを有効化する
 - 有効化の方法
   1. `ランタイム`
   2. `ランタイムのタイプの変更`
   3. `ハードウェアのアクセラレータ`
   4. `GPU`を選択する

## 出力を消す(隠す)
 - 出力を消す方法(ハンバーガーボタン)
   1. セルのハンバーガーボタンを選択
   2. 出力を消去
 - 出力を消す方法(出力欄)
   1. 出力欄の左上をホバーするとxボタンが出現する
   2. xボタンをクリックすると消える

## colabのフォントを変更する
 - jupyterとは異なり、iframeを使っているようで、`display(HTML())`が動作しない
 - ブラウザの拡張機能のtempermonkeyをインストール
 - tempermonekyの[ユーザ作成のスクリプト](https://greasyfork.org/en/scripts/438954-change-google-colab-font)をインストール

## 細かい使い方

### vimのキーバインディング
 - `[ツール]` -> `[設定]` -> `[エディタ]` -> `[vim]を選択`

### vimiumの特定のキーの無効化
 - `b`が干渉するので無効化

### インターネット上の全員に公開
 - `[共有]` -> `[リンクを取得]` -> `[変更]から"リンクを知っている全員"を選択` -> `[完了]`
   - コメントや提案はフィードバックされるらしい

---

## 参考
 - [Colab でデータを探索する/Google Cloud](https://cloud.google.com/bigquery/docs/explore-data-colab)
