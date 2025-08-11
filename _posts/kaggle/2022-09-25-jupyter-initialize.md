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
    print("japanize_matplotlib was not found.")
%config InlineBackend.print_figure_kwargs={'facecolor' : "w"} # matplot, seabornが生成するpngが透明にならないようにする
from IPython.display import HTML, display, Markdown # HTML, Markdownの描画を有効化する
display(HTML("<style>.container { width:85% !important; }</style>")) # jupyter notebookの幅を設定
display(HTML("""<style type='text/css'>.CodeMirror{ font-size: 13px; font-family: "PlemolJP Console NF"; }</style>""")) # フォントを設定
import pandas as pd
pd.options.display.float_format = '{:,.6f}'.format # 小数点以下6桁まで表示
pd.set_option('display.max_columns', None) # columnを省略せず表示
import numpy as np
np.random.seed(42) # 乱数のシードを固定
from tqdm.auto import tqdm
import os
import gzip
import json
import glob
import pprint; pp = pprint.PrettyPrinter(indent=2, width=120, depth=6)
import warnings; warnings.filterwarnings("ignore", category=UserWarning,) # ユーザーワーニングを無視
from joblib import Parallel, delayed, parallel_backend # 並列処理
from joblib import hash as jhash; assert jhash("aiueo") == "56f49dd184d759edae89c96f0822001a"; # 再現性のあるハッシュ関数
import itertools # イテレータの生成
from pathlib import Path
import hashlib
def compute_hash(text: str) -> str: return hashlib.sha256(text.encode('utf-8')).hexdigest()[:32]
# pandasのDataFrameを表示する際に、全ての情報を表示する関数
def display_full(df): (lambda c: (c.__enter__(), display(df), c.__exit__()))\
    (pd.option_context("display.max_colwidth", None, "display.max_rows", None, "display.max_columns", None))
from jinja2 import Template, Environment; JinjaEnv = Environment(variable_start_string='[[', variable_end_string=']]')
from loguru import logger
# jupyter aiの有効化
%load_ext jupyter_ai
%ai register gpt-4o openai-chat:gpt-4o 
```
