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
   - poetry形式で管理されたモジュールやライブラリでもpipでインストールできる
 - インストール可能な対象は以下の通り
   - pypiで管理されたパッケージ
   - gitで管理されたパッケージ
   - zip形式のパッケージ
 - [PEP 668](https://peps.python.org/pep-0668/)の提案により、グローバル環境にインストールすることは非推奨となった

## PEP 668以降でグローバル環境にインストールする方法
 - `pip3 install <packagename> --break-system-packages`を用いる
 - 環境変数`PIP_BREAK_SYSTEM_PACKAGES="1"`を設定する

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
 - 強制インストールのユースケース以外では、colabで使用する際に現在のpandas, numpyの整合性を壊さないなどのユースケースもある

```console
$ pip install --upgrade --no-deps --force-reinstall <packagename>
```

## `requirements.txt`と`constraints.txt`
 - `requirements.txt`
   - 必要なパッケージ
   - バージョンは`package==x.y.z`と表現
   - 指定しないと、最新版が使用される
   - 範囲指定は`package<X.Y.Z,>=x.y.z`と表現する
 - `constraints.txt`
   - サブパッケージ
   - `requirements.txt`より優先される
   - 複数のプロジェクトで共用するなどを想定されているファイル
     - 複数間のプロジェクトで同じバージョンを維持したい時

## 指定のpythonのバージョンを無視してインストール

```console
$ pip install --ignore-requires-python <packagename>
```

## 特定のgithubのブランチからインストール
 - URLの前に`git+`のプレフィックスが必要
 - `@<branch-name>`のサフィックスが必要

```console
$ python3 -m pip install git+https://github.com/Garve/mamimo.git@main
```

## zip形式のパッケージをインストール
 - google colabなどで社内開発したパッケージを利用したい場合など、google driveにzipで置いてインストール可能

```console
$ python3 -m pip install ./<path-to-zipped-library.zip>
```

## pip freeze
 -  今、インストールされているパッケージをバージョン情報を付与してstdoutに出力

```console
$ pip freeze | less
apt-xapian-index==0.49
apturl==0.5.2
argon2-cffi==21.3.0
argon2-cffi-bindings==21.2.0
...
```

---

## トラブルシューティング

### OSX(mac)でpipでインストールしたはずの実行ファイルが見つからない
 - 原因
   - brewのpythonを用いていると以下のディレクトリにインストールされることがあるため
     - `~/Library/Python/<python-version>/bin`
 - 対応
   - パスが通っている空間にシンボリックリンクを貼る、PATHを追加するなど
 
---

## 参考
 - [Python 3.11, pip and (breaking) system packages](https://veronneau.org/python-311-pip-and-breaking-system-packages.html)

