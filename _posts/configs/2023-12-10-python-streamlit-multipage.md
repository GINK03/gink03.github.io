---
layout: post
title: "python streamlit multipage"
date: 2023-12-10
excerpt: "streamlitのmultipageの概要と使い方"
config: true
tag: ["streamlit", "python", "multipage"]
comments: false
sort_key: "2023-12-10"
update_dates: ["2023-12-10", "2026-04-26"]
---

# streamlitのmultipageの概要と使い方

## 概要
 - streamlitは基本はsingle pageで動作するが、multipageで動作させることもできる
 - 各pageは独立しているが、`st.session_state`を使うことで、page間でのデータのやり取りが可能
 - Streamlit 1.36以降は `st.Page` + `st.navigation` を使う方式が推奨（旧来の `pages/` ディレクトリ自動検出方式は非推奨）

## 新方式（推奨）: `st.Page` + `st.navigation`

エントリポイントファイル（`streamlit run` に渡すファイル）でページを明示的に定義する

**ディレクトリ構造**
```
app.py          ← エントリポイント
pages/
  home.py
  settings.py
  dashboard.py
```

**app.py**
```python
import streamlit as st

pg = st.navigation([
    st.Page("pages/home.py", title="Home", icon="🏠"),
    st.Page("pages/dashboard.py", title="Dashboard", icon="📊"),
    st.Page("pages/settings.py", title="Settings", icon="⚙️"),
])
pg.run()
```

 - `st.navigation()` はエントリポイントファイルで1回だけ呼ぶ
 - 戻り値の `.run()` で現在のページを実行する
 - ページはPythonファイルパスまたはCallable（関数）で指定できる

## セクション分け

`st.navigation` にdictを渡すとセクションヘッダー付きのナビになる

```python
pg = st.navigation({
    "分析": [
        st.Page("pages/dashboard.py", title="Dashboard", icon="📊"),
        st.Page("pages/report.py", title="Report", icon="📄"),
    ],
    "設定": [
        st.Page("pages/settings.py", title="Settings", icon="⚙️"),
    ],
})
pg.run()
```

## ページをCallableで定義する

ファイルではなく関数をページとして渡すこともできる

```python
import streamlit as st

def home():
    st.title("Home")
    st.write("Welcome!")

def settings():
    st.title("Settings")

pg = st.navigation([
    st.Page(home, title="Home", icon="🏠"),
    st.Page(settings, title="Settings", icon="⚙️"),
])
pg.run()
```

## ロールベースの動的ナビゲーション

`st.navigation` に渡すページリストをrerunごとに変えることで、ロール別のナビが実現できる

```python
import streamlit as st

role = st.session_state.get("role")

pages = [st.Page("pages/home.py", title="Home")]

if role == "admin":
    pages.append(st.Page("pages/admin.py", title="Admin", icon="🔒"))

pg = st.navigation(pages)
pg.run()
```

## ナビゲーションの表示位置

`position` パラメータで位置を変更できる

 - `"sidebar"` (デフォルト): サイドバーの上部に表示
 - `"top"`: アプリ上部のヘッダーに表示
 - `"hidden"`: ナビを非表示にして `st.page_link` で独自メニューを実装する

```python
pg = st.navigation(pages, position="top")
pg.run()
```

## 旧方式（非推奨）

`pages/` ディレクトリにファイルを置くとStreamlitが自動検出する方式。1.36以降は非推奨

```
home.py
pages/
  00_💫_aaa.py
  01_🍊_bbb.py
  02_❤_ccc.py
```

 - ファイル名の先頭の数字で並び順を制御していた
 - ファイル名のアンダースコア区切りでアイコンを設定していた
 - 新方式では `st.Page` の `title` と `icon` パラメータで明示的に設定する
