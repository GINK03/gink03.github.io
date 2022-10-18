---
layout: post
title: "pip"
date: 2021-03-09
excerpt: "pythonのpipついて"
tags: ["pip", "python"]
config: true
comments: false
sort_key: "2022-04-15"
update_dates: ["2022-04-15","2022-01-02","2021-11-01","2021-10-27","2021-03-09"]
---

# pythonのpipついて

## 概要
 - pythonのパッケージマネージャ
 - よりロバストに管理したい場合は、poetryが用いられる

## rootとuser
 
***root***  
```console
$ sudo pip3 install <hoobar>
```

***user***  
```console
$ pip3 install --user <hoobar>
```
 - `--user`オプションをつけると`$HOME/.local/lib/`以下にインストールされる

### `pip3`のpathと`python3`のpathのレベルが異なるとき

```console
$ python3 -m pip install <hoobar>
```
 - python3経由で実行すると明示的にpip3が選択される

### `requirements.txt`からインストールする

```console
$ python3 -m pip install -r requirements.txt
```

## モジュールとしてのpipからインストールする

**モジュールがインストールされているかの確認をして入っていなかったらインストールする例**  

```python
import importlib.util
import pip
for pkg_name in ["requests", "bs4", "loguru"]:
    if importlib.util.find_spec(pkg_name) is None:
        pip.main(["install", pkg_name])
```

## 依存を無視してインストール
 - グローバル環境がおかしくなるリスクがあるので、使う必要がある場合はpoetryなどで環境を分ける

```console
$ pip install --upgrade --no-deps --force-reinstall <packagename>
```

## トラブルシューティング

### OSX(mac)でpipでインストールしたはずの実行ファイルが見つからない
 - 原因
   - brewのpythonを用いていると以下のディレクトリにインストールされることがあるため
     - `~/Library/Python/<python-version>/bin`
 - 対応
   - パスが通っている空間にシンボリックリンクを貼る、PATHを追加するなど
 
