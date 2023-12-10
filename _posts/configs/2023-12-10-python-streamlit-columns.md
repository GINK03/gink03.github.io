---
layout: post
title: "python streamlit columns"
date: 2023-12-10
excerpt: "streamlitのcolumnsの概要と使い方"
config: true
tag: ["streamlit", "python", "columns"]
comments: false
sort_key: "2023-12-10"
update_dates: ["2023-12-10"]
---

# streamlitのcolumnsの概要と使い方

## 概要
 - streamlitは2023年現在columns以外でのレイアウト設定ができない

## 使い方

```python
import streamlit as st

st.title("title")

# 1:9の比率で分割
col1, col2 = st.columns([1, 9]))
with col1:
    st.checkbox("checkbox", key="checkbox")
with col2:
    st.markdown("markdown")
```

## 参考
 - [st.columns](https://docs.streamlit.io/library/api-reference/layout/st.columns)

