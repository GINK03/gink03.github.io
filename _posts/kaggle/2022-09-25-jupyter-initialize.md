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
import os, sys, gzip, json, glob, itertools, importlib, hashlib # builtins
from pathlib import Path
from typing import Any, Optional, Union, List, Dict, Tuple, Callable, Iterable, Sequence, Mapping
import warnings; warnings.filterwarnings("ignore", category=UserWarning,) # ユーザーワーニングを無視
from pprint import PrettyPrinter; pp = PrettyPrinter(indent=2, width=120, depth=6)
from joblib import Parallel, delayed, parallel_backend # 並列処理
from joblib import hash as jhash; assert jhash("aiueo") == "56f49dd184d759edae89c96f0822001a" # 再現性のあるハッシュ関数
import nest_asyncio; nest_asyncio.apply() # イベントループの再入可能化
import numpy as np; np.random.seed(42) # 乱数のシードを固定
import pandas as pd; pd.options.display.float_format = '{:,.6f}'.format; pd.set_option('display.max_columns', None) # columnを省略せず表示
# visualization
import seaborn as sns
import matplotlib
import matplotlib.pyplot as plt
import matplotlib.dates as mdates # time seriesの描画
%config InlineBackend.print_figure_kwargs={'facecolor' : "w"} # matplot, seabornが生成するpngが透明にならないようにする
japanize_spec = importlib.util.find_spec("japanize_matplotlib")
if japanize_spec: import japanize_matplotlib
else: print("japanize_matplotlib was not found.")
# jupyter
from IPython.display import HTML, display, Markdown;
display(HTML("<style>.container { width:85% !important; }</style>"));
display(HTML("<style type='text/css'>.CodeMirror{ font-size: 13px; font-family: \"PlemolJP Console NF\"; }</style>")) # HTML, Markdownとスタイルの設定
from tqdm.auto import tqdm
from jinja2 import Template, Environment; JinjaEnv = Environment(variable_start_string='[[', variable_end_string=']]')
# logging
import rich.jupyter
from rich.logging import RichHandler
from loguru import logger
rich.jupyter.JUPYTER_HTML_FORMAT = (
    "<pre style=\"white-space:pre;overflow-x:auto;line-height:normal;"
    "font-family:Menlo,'DejaVu Sans Mono',consolas,'Courier New',monospace;"
    "margin:0px;padding:0px\">{code}</pre>"
)
logger.remove()
logger.add(RichHandler(rich_tracebacks=True, omit_repeated_times=False, show_path=False), format="{message}", level="INFO")
# utils
def compute_hash(text: str) -> str: return hashlib.sha256(text.encode('utf-8')).hexdigest()[:32]
# pandasのDataFrameを表示する際に、全ての情報を表示する関数
def display_full(df: pd.DataFrame) -> None:
    with pd.option_context("display.max_colwidth", None, "display.max_rows", None, "display.max_columns", None):
        display(df)
```
