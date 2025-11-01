---
layout: post
title: "Google Drive"
date: "2022-01-14"
excerpt: "Google Drive の仕組みと概要"
project: false
config: true
tag: ["google", "google apps", "ネットワークドライブ"]
comments: false
sort_key: "2022-04-25"
update_dates: ["2022-04-25","2022-04-24","2022-04-16","2022-01-14"]
---

# Google Drive の仕組みと概要

## 概要
 - Google Apps のネットワークドライブ
 - S3 や GCS に近い仕組みになっており通常の HDD とは異なる
   - HDD のようにして使うと API 制限にすぐ到達する
 - ファイルが所属するディレクトリのことを `parent` という
 - GCP の Google Drive API を利用することでプログラマティックに操作できる

## 仕組み
 - ファイルとディレクトリには名前とは別に `fileId` と呼ばれる固有のハッシュ値のようなものが存在する
 - `fileId` がつながることで木構造になりディレクトリ構造を提供している
 - 構造例
   - `fileId1`(ディレクトリ)
     - `fileId2`(ファイル)
     - `fileId3`(ディレクトリ)
       - `fileId4`(ファイル)
       - `fileId5`(ファイル)

## Python でファイルのダウンロード
 - GCP で Google Drive API を有効化
 - `gcloud auth application-default login --scopes="https://www.googleapis.com/auth/drive.readonly,https://www.googleapis.com/auth/cloud-platform"` で ADC を設定

```python
from googleapiclient.discovery import build
from googleapiclient.http import MediaIoBaseDownload
import google.auth, io, pathlib

FILE_ID = "1QDDZ2IoGN8xOzeu_********"
DEST    = pathlib.Path("video.mp4")

# 「Drive 読み取り専用」スコープで ADC を取得
scopes = ["https://www.googleapis.com/auth/drive.readonly"]
creds, _ = google.auth.default(scopes=scopes)          # gcloud で得た資格情報を自動読込

service = build("drive", "v3", credentials=creds)
request = service.files().get_media(fileId=FILE_ID)

with io.FileIO(DEST, "wb") as fh:
    downloader = MediaIoBaseDownload(fh, request)
    done = False
    while not done:
        status, done = downloader.next_chunk()
        print(f"{status.progress()*100:.1f} % downloaded")
print("✅ 完了:", DEST)
```

## 使用できるクライアントソフト

### [(macOS) Google Drive for Desktop](https://support.google.com/a/users/answer/9965580?hl=en)
 - 公式クライアント
 - macOS で実行すると SMB プロトコルで `/Volumes/GoogleDrive/` にマウントされる
 - 公式で実装されているので CLI でアクセスしても安定している

### [(Windows) Google Drive for Windows](https://www.google.com/drive/download/)
 - 特徴
   - macOS 版は `/Volumes` 以下に配置されるが Windows 版は Google Drive という名前のハードディスクが作成される
   - データの管理方式はストリーミングとミラーリングがある
     - ストリーミング -> アクセス時にデータを取得
     - ミラーリング -> すべてのデータをミラーリング(HDD の消費が激しい)
   - パスの実態
      - `C:\Users\<username>\AppData\Local\Google\DriveFS`であり張り替えることは可能

### [/gdrive/](/gdrive/)
 - Linux と macOS で使用できる CUI クライアント


## どれくらいの容量を契約すればいいのか
 - 結論
   - 最小の契約の 100 GB で十分
 - 理由
   - そもそもエグレス料金を無視した料金体系で金額的に相当マージンを乗せているため他社に比べて高い
   - あふれるようなデータは Backblaze や S3 で保存すればよい
   - どうしてもエグレス料金がかさみそうなときは self-host で解決する
     - 環境がない場合、[/bore/](/bore/)などで自分のコンピュータのポートを公開すれば世界からアクセス可能になる


## トラブルシューティング

### たくさんのファイルの移動・削除ができない
 - macOS や Windows のクライアントで操作すると極端に遅くなるので WebUI から行う
