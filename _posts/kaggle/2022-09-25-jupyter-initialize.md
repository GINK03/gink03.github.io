---
layout: post
title: "jupyter initialize"
date: 2022-09-25
excerpt: "jupyterのinitialize(初期化)のチートシート"
tags: ["jupyter"]
kaggle: true
comments: false
sort_key: "2022-09-25"
update_dates: ["2022-09-25"]
---

# jupyterのinitialize(初期化)のチートシート

## 概要
 - jupyter notebookを起動した際に、最初に記述しておくコードのスニペット

## コード

```python
import seaborn as sns
import matplotlib
# matplotlib.use('agg') # python scriptのときは有効化する
import matplotlib.pyplot as plt
import matplotlib.dates as mdates # time seriesの描画
import importlib
if importlib.util.find_spec("japanize_matplotlib"):
    import japanize_matplotlib
else:
    # 日本語フォントが入っていないなど/
    import os
    os.system("pip install japanize-matplotlib")
    import japanize_matplotlib
%config InlineBackend.print_figure_kwargs={'facecolor' : "w"} # matplot, seabornが生成するpngが透明にならないようにする

# HTMLの描画を有効化する
from IPython.display import HTML, display
# jupyter notebookの幅を設定
display(HTML("<style>.container { width:85% !important; }</style>"))
# フォントを設定
display(HTML("""<style type='text/css'>.CodeMirror{ font-size: 13px; font-family: "PlemolJP Console NF"; }</style>"""))
#display(HTML("""<style type='text/css'>.CodeMirror{ font-size: 13px; font-family: "SF Mono"; } </style>"""))

# よく使うライブラリ
import pandas as pd
import numpy as np
from tqdm.auto import tqdm

# データフレームを表示する際に浮動小数点数のフォーマットを指定
pd.options.display.float_format = '{:,.6f}'.format

# 表示するカラムの上限
pd.set_option('display.max_columns', None)

# ワーニングをフィルタしたい際
import warnings
warnings.filterwarnings("ignore", category=UserWarning,) # ユーザーワーニングを無視
#from pandas.core.common import SettingWithCopyWarning
#warnings.simplefilter(action="ignore", category=SettingWithCopyWarning) # コピーの警告

import gzip
import pandas as pd
import json
import glob
import pprint
pp = pprint.PrettyPrinter(indent=2, width=120, depth=6)
```
