---
layout: post
title: "python streamlit dataframe"
date: 2023-12-08
excerpt: "streamlitのdataframeの表示方法"
config: true
tag: ["streamlit", "python"]
comments: false
sort_key: "2023-12-08"
update_dates: ["2023-12-08"]
---

# streamlitのdataframeの表示方法

## 概要
 - streamlitでdataframeを表示するには２つの方法がある
   - `st.dataframe`
     - streamlitのデフォルトの表示方法
   - `st.data_editor`
     - streamlitのデータエディターを使った表示方法
     - 高機能

## st.dataframe

```python
import streamlit as st
import pandas as pd

df = pd.DataFrame({
    "A": [1, 2, 3],
    "B": [4, 5, 6],
    "C": [7, 8, 9]
})

st.dataframe(df,
             hide_index=True, # 行番号を非表示
    )
```

## st.data_editor

```python
import streamlit as st
import pandas as pd

df = pd.DataFrame({
    "CheckBox": [True, False, True], # チェックボックスとして表示
    "A": ["aaa", "bbb", "ccc"],
    "B": [4, 5, 6],
    "C": ["cat0", "cat1", "cat2"]
})

# edited_dfには編集後のデータが入る
edited_df = st.data_editor(df,
             hide_index=True, # 行番号を非表示
             use_container_width=True, # 幅を画面幅に合わせる
             column_config={ # 列ごとの設定
                 "CheckBox": st.column_config.CheckboxColumn(
                      "選択", # チェックボックスのラベル
                      width="small", # 幅を小さくする
                 ),
                 "A": st.column_config.TextColumn(
                      "Aテキスト", # テキストボックスのラベル
                      width="midium", # 幅を中くらいにする
                      disabled=True, # 編集不可にする
                 ),
                 "C": st.column_config.SelectboxColumn(
                      "C選択", # セレクトボックスのラベル
                      options=["cat0", "cat1", "cat2"], # セレクトボックスの選択肢
                      width="large", # 幅を大きくする
                 ),
             },
          )
```
