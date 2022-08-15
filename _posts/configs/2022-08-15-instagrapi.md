---
layout: post
title: "instagrapi"
date: "2022-08-15"
excerpt: "instagrapiの使い方"
config: true
tag: ["instagram", "API"]
comments: false
sort_key: "2022-08-15"
update_dates: ["2022-08-15"]
---

# instagrapiの使い方

## 概要
 - instagramのAPIを拡張する形で使用できるデータ取得ツール
 - 公式APIでできることをこれで自動化するとbanされることがあるらしい
 - 操作を誤ると、規約違反を起こせるので注意する

## ドキュメント
 - [instagrapi](https://adw0rd.github.io/instagrapi/usage-guide/)

## 具体例

```python
from pathlib import Path
import json
from instagrapi import Client

# ログインに成功したらログイン情報を保存する
if not Path("settings.json").exists():
    # ref. https://github.com/adw0rd/instagrapi/issues/46
    ACCOUNT_USERNAME = "DAMMY"
    ACCOUNT_PASSWORD = "DAMMY"
    verification_code = "530778"
    cl = Client()
    cl.login(ACCOUNT_USERNAME, ACCOUNT_PASSWORD, verification_code=verification_code)
    json.dump(
        cl.get_settings(),
        open('settings.json', 'w')
    )

cl = Client(json.load(open('settings.json')))

def get_data(user_name):
    if Path(user_name).exists():
        return
    user_info = cl.user_info_by_username(user_name).dict()
    Path(user_name).mkdir(exist_ok=True)
    with open(f'{user_name}/info.json', "w") as fp:
        json.dump(user_info, fp, ensure_ascii=False, indent=2)

    user_id = cl.user_id_from_username(user_name)
    medias = cl.user_medias(user_id, 50)

    for media in medias:
        # メディアのキャプション(コメント)を確認する
        pk = media.dict()["pk"]
        caption_text = media.dict()["caption_text"]
        with open(f"{user_name}/{pk}.txt", "w") as fp:
            fp.write(caption_text)

        # メディアの内容を取得、保存する
        match (media.dict()["media_type"], media.dict()["product_type"]):
            case (1, _):
                cl.photo_download(media.dict()["pk"], Path(user_name))
            case (2, "feed"):
                cl.video_download(media.dict()["pk"], Path(user_name))
            case (2, "igtv"):
                pass
            case (2, "clips"):
                cl.clip_download(media.dict()["pk"], Path(user_name))
            case (8, _):
                cl.album_download(media.dict()["pk"], Path(user_name))
            case (x, y):
                print(x, y)
```
