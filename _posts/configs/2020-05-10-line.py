---
layout: post
title: "line"
date: 2020-04-30
excerpt: "line"
tags: [line]
config: true
comments: false
---

# line notify
ラインを用いて作ったアプリとかの監視ができる  
PoCとかかんたんなWebサイトの監視とかに便利  

## データやメッセージの贈り方

以下の例ではwebサイトが一定以上応答しない場合、status_codeが異常な場合、自分に送信するものである

```python
import schedule
import json
import requests
import time

TOKEN = "uy19NzDMlHTdmMFr54lnDoKZXWQhEv0D9bRaSXqsICF"
URL = "https://notify-api.line.me/api/notify"

def send_to_line(message: str) -> None:
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + TOKEN
    }
    data = {"message": f"{message}"}
    ret = requests.post(URL, params=data, headers=headers)


def watch_dog():
    try:
        with requests.get("https://concertion.page", timeout=60) as r:
            if r.status_code != 200:
                raise Exception(f"status_code error = {r.status_code}")
    except Exception as exc:
        send_to_line(str(exc))

watch_dog()

while True:
    schedule.every(10).minutes.do(watch_dog)
    time.sleep(1)
```


