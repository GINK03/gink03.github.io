---
layout: post
title: "jupyter cull"
date: 2025-01-29
excerpt: "jupyter cull(自動削除)の使い方"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2025-01-29"
update_dates: ["2025-01-29"]
---

# jupyter cull(自動削除)の使い方

## 概要
 - jupyter serverの機能の一つで一定期間使用されいないカーネルを自動で削除(停止)する機能
 - メモリの節約になる

## 設定方法

**jupyter serverの設定ファイルを作成**
 - `~/.jupyter/jupyter_server_config.py`を作成

```console
$ jupyter server --generate-config
```

**設定ファイルに以下を追記**
```python
# Configuration file for jupyter-server.

c = get_config()  #noqa

# 使用していないとき、サーバーごとシャットダウンする設定
# c.ServerApp.shutdown_no_activity_timeout = 3600 * 12

# idle状態のカーネルをシャットダウンするまでの待ち時間（秒）
c.ServerApp.MappingKernelManager.cull_idle_timeout = 3600 * 12 # 12時間

# 定期的にアイドル状態をチェックする間隔（秒）
c.ServerApp.MappingKernelManager.cull_interval = 300  # 例：5分ごと

# cull_connected=True にすると、
# ブラウザなどからWebSocket接続が残っていてもアイドルなら終了させる
c.ServerApp.MappingKernelManager.cull_connected = True

c.ServerApp.open_browser = False
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.token = ''
c.ServerApp.password = ''
c.ServerApp.port = 8888
```

