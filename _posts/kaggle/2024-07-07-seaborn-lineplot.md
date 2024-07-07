---
layout: post
title: "seaborn lineplot"
date: 2024-07-07
excerpt: "seaborn"
tags: ["seaborn", "python", "matplotlib", "可視化"]
kaggle: true
comments: false
sort_key: "2024-07-07"
update_dates: ["2024-07-07"]
---

# seaborn lineplot


## lineplotを描画する

```python
ax = sns.lineplot(x="{PANDAS_COL_NAME0}", y="{PANDAS_COL_NAME1}")
```
 - `label`引数で、凡例(legend)を追加できる

### 複数のlineplotを描画し、信頼区間も描画する

```python
plt.figure(figsize=(20, 10))
plt.xticks(rotation=90)
ax = sns.lineplot(data=df, x="round_time", y="throughput", hue="proto", errorbar=('ci', 90))
ax
```
 - `hue` - おのおのの描画をグルーピングするキーワード
 - `errorbar=(ci, 90)` - 信頼区間90%を描画する
   - ciはconfidence intervalの略
   - 信頼区間を描画する場合は`x`の値が複数ある必要がある

<div align="center">
  <img style="align: center !important; width: 300px !important;" src="https://user-images.githubusercontent.com/4949982/176080593-95ec45a6-1afc-4bc9-aea9-78aa0a7bca4c.png">
</div>

