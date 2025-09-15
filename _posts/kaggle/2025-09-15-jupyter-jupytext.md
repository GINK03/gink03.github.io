---
layout: post
title: "jupyter jupytext"
date: 2025-09-15
excerpt: "jupyter jupytextの概要と使い方"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2025-09-15-jupyter-jupytext"
update_dates: ["2025-09-15"]
---

# jupyter jupytextの概要と使い方

## 概要
 - Jupytextは、Jupyter Notebook（`.ipynb`）ファイルと、プレーンテキスト形式のファイル（`.py`や`.md`など）を双方向に同期するためのツール
 - Jupyter LabでJupytextを使用してファイルを同期させると、ノートブックを更新するたびに、ペアリングされた`.py`や`.md`ファイルも自動的に更新される
 - 逆に、`.py`や`.md`ファイルを編集すると、その変更が`.ipynb`ノートブックにも反映される
   - ノートブックを開いている場合は、ブラウザをリロードすることで変更内容を確認できる
 - ユースケースとして軽い分析はブラウザで行い、複雑な実装は `.py` に吐き出しコーディングエージェントと協業して実装するなどが考えられる

## インストール

```console
$ pip install jupytext
```

## 使い方

### `pyproject.toml` に設定を追加

```toml
[tool.jupytext]
formats = "ipynb,py:percent"
notebook_metadata_filter = "-jupytext"
```

### Jupyter Labでのペアリング設定
 - 1. `Cmd + Shift + C` でコマンドパレットを開く
 - 2. 「jupytext」と入力し、「**Pair Notebook with percent script**」を選択

これにより、ノートブックとPythonスクリプト（`.py`）がペアリングされる。
「percent script」形式は、VS CodeのJupyter拡張機能などで使われるセル区切り（`# %%`）と同じ形式

### 手動で同期を行う

```console
$ jupytext --sync your_script.py
```

