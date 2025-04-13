---
layout: post
title: "python streamlit"
date: 2023-09-03
excerpt: "streamlitの概要と使い方"
config: true
tag: ["streamlit", "python"]
comments: false
sort_key: "2023-09-03"
update_dates: ["2023-09-03"]
---

# streamlitの概要と使い方

## 概要
 - pythonで簡単なMVPを作成できるライブラリ
   - jupyterを共有するほどでも無いが、google sheetsより自由度が高いほうがいいぐらいの位置づけのとき
 - GCPのcloud runでホストすることが可能
   - 独自のドメインを与えたロードバランサー(httpsに限定) + IAPを組み合わせることでGCPのIAMで `roles/iap.httpsResourceAccessor` を持つユーザに限定することができる

## インストール

```console
$ pip install streamlit
```

## ページの設定
 - デフォルトでは表示幅が狭く、テーブルが見づらいので、`st.set_page_config`で設定する

```python
import streamlit as st
st.set_page_config(
  layout="wide",
  page_icon="🏠",
  initial_sidebar_state="expanded",
  page_title="Streamlit Example",
)
```

## ページの遷移
 - `st.experimental_set_query_params` や `st.session_state` を使うことで、ページの遷移を実現できる
 - URLパラメータを設定するのにタイムラグがあるので意図した動作にならないことがある

## 最小の構成例

```python
import streamlit as st
import pandas as pd

# タイトルを追加
st.title('Streamlit Example')

# サイドバーにテキスト入力を追加
user_input = st.sidebar.text_input("Type something here")

# メイン画面にテキスト入力の内容を表示
st.write(f"You typed: {user_input}")

# データフレームの表示
data_url = 'https://raw.githubusercontent.com/fivethirtyeight/data/master/airline-safety/airline-safety.csv'
df = pd.read_csv(data_url)
st.dataframe(df)

# カメラから写真を撮る(httpsに限定)
img_file_buffer = st.camera_input("Take a picture")
```

## 起動
 - 外部からアクセスするには`--server.address 0.0.0.0`が必要になる
 - `--server.headless true`を指定しないと、ローカルで起動したときにブラウザが立ち上がる

```console
$ streamlit run src/app.py --server.port 8080 --server.address "0.0.0.0" --server.headless true
```

## Dockerfileの例

```dockerfile
FROM python

ENV POETRY_VIRTUALENVS_CREATE=false

RUN apt-get update -y && apt-get install -y
RUN pip install --upgrade pip && pip install poetry

WORKDIR /app
COPY . /app/

RUN poetry install --no-ansi --no-interaction

CMD sh -c "streamlit run src/app.py --server.port 8080 --server.address 0.0.0.0"
```

## 参考
 - [Streamlit cheat sheet](https://cheat-sheet.streamlit.app)
 - [Cloud Run で Identity-Aware Proxy (IAP) を使う](https://zenn.dev/ww24/articles/19099c85febe0d)
 - [Streamlit + Cloud Run + IAPで自分だけのChatGPTアプリをデプロイしてみた](https://qiita.com/suzuki_sh/items/fb7a21426043d8520dbe)
 - [ブラウザで動くリアルタイム画像/音声処理アプリをStreamlitでサクッと作る](https://zenn.dev/whitphx/articles/streamlit-realtime-cv-app)
