---
layout: post
title: "python systemd"
date: 2024-10-26
excerpt: "python systemdの使い方"
tags: ["python", "systemd", "journald", "logging"]
config: true
comments: false
sort_key: "2024-10-26"
update_dates: ["2024-10-26"]
---

# python systemdの使い方

## 概要
 - pythonでlinuxのsystemd-journaldにログを出力する方法
 - `systemd` というライブラリを使う

## インストール

**debian/ubuntu**
```console
$ sudo apt install libsystemd-dev
$ pip install systemd
```

## サンプルコード

```python
from systemd import journal

# ログメッセージを送信
journal.send(
    MESSAGE='カスタムフィールドを含むログメッセージ',
    SYSLOG_IDENTIFIER='my_application',
    PRIORITY=journal.Priority.INFO,
    CUSTOM_FIELD1='追加情報1',
    CUSTOM_FIELD2='追加情報2'
)
```

```console
$ journalctl --user -o json-pretty -n 1
{
        "CUSTOM_FIELD2" : "追加情報2",
        "CODE_LINE" : "65",
        "MESSAGE" : "カスタムフィールドを含むログメッセージ",
        "CUSTOM_FIELD1" : "追加情報1",
        "PRIORITY" : "6",
        ...
        "SYSLOG_IDENTIFIER" : "my_application"
}
```

## コードスニペット

```python
from systemd import journal

def logger_debug(message, **kwargs):
    journal.send(
        MESSAGE=message,
        SYSLOG_IDENTIFIER='my_application',
        PRIORITY=journal.Priority.DEBUG,
        **kwargs
    )

def logger_warning(message, **kwargs):
    journal.send(
        MESSAGE=message,
        SYSLOG_IDENTIFIER='my_application',
        PRIORITY=journal.Priority.WARNING,
        **kwargs
    )

def logger_error(message, **kwargs):
    journal.send(
        MESSAGE=message,
        SYSLOG_IDENTIFIER='my_application',
        PRIORITY=journal.Priority.ERROR,
        **kwargs
    )
```
