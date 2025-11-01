---
layout: post
title: "Google Drive Python"
date: 2025-11-01
excerpt: "Google Drive API を Python で使う例"
config: true
tag: ["google", "python", "google drive", "api"]
comments: false
sort_key: "2025-11-01"
update_dates: ["2025-11-01"]
---

# Google Drive を Python で使う

## 事前準備
 - GCP で Google Drive API を有効化
 - `gcloud auth application-default login --scopes="https://www.googleapis.com/auth/drive.readonly,https://www.googleapis.com/auth/cloud-platform"` で ADC を設定

## ファイルのダウンロード

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

## 再帰で mp4 を列挙

 - ディレクトリ ID を起点に再帰で探索し mp4 のみ抽出

```python
from googleapiclient.discovery import build
import google.auth

SCOPES = [
    "https://www.googleapis.com/auth/drive.readonly",
]
creds, _ = google.auth.default(scopes=SCOPES)
service = build("drive", "v3", credentials=creds)

def list_mp4s(service, folder_id):
    seen = set()

    def children(fid):
        q = f"'{fid}' in parents and trashed=false"
        fields = (
            "nextPageToken, files("
            "id,name,mimeType,"
            "shortcutDetails/targetId,shortcutDetails/targetMimeType)"
        )
        tok, out = None, []
        while True:
            r = service.files().list(
                q=q,
                fields=fields,
                includeItemsFromAllDrives=True,
                supportsAllDrives=True,
                corpora="allDrives",
                pageToken=tok,
                pageSize=1000,
                spaces="drive",
            ).execute()
            out += r.get("files", [])
            tok = r.get("nextPageToken")
            if not tok:
                break
        return out

    def is_mp4(name, mtype):
        return (mtype == "video/mp4") or str(name or "").lower().endswith(".mp4")

    def walk(fid, acc):
        if fid in seen:
            return
        seen.add(fid)
        for f in children(fid):
            mime = f.get("mimeType")
            is_sc = mime == "application/vnd.google-apps.shortcut"
            sd = f.get("shortcutDetails") or {}
            tid, tmime = sd.get("targetId"), sd.get("targetMimeType")

            if mime == "application/vnd.google-apps.folder":
                walk(f["id"], acc)
                continue
            if is_sc and tmime == "application/vnd.google-apps.folder" and tid:
                walk(tid, acc)
                continue

            if is_mp4(f.get("name"), mime):
                acc.append({
                    "id": f["id"],
                    "name": f.get("name"),
                    "mimeType": mime,
                    "is_shortcut": False,
                })
                continue
            if is_sc and tid and is_mp4(f.get("name"), tmime):
                acc.append({
                    "id": tid,
                    "name": f.get("name"),
                    "mimeType": tmime,
                    "is_shortcut": True,
                })

    results = []
    walk(folder_id, results)
    return results

# 例
# vids = list_mp4s(service, "<FOLDER_ID>")
# print(len(vids), "files")
```
