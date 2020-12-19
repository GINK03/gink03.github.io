---
layout: post
title: "matplotlib"
date: 2020-12-19
excerpt: "matplotlib"
project: false
config: true
tag: ["matplotlib"]
comments: false
---

# matplotlib

## style
```python
import matplotlib.style
matploglib.style.use("ggplot")
```

## 最もシンプルな描画
```python
import matplotlib.pyplot as plt
x, y = something data
plt.plot(x, y)
plt.show()
```

## subplot
*シンプル*
```python
fig, ax = plt.subplots()
ax.plot(x, y)
plt.show()
```

*2つに横に分割*
```python
fig, axes = plt.subplots(2)
plt.show()
```

*4つに縦横に分割*
```python
fig, axes = plt.subplots(2, 2)
plt.show()
```

*横に2つの分割*
```python
fig, axes = plt.subplots(ncols=2)
plt.show()
```

## 凡例
```python
fig, ax = plt.subplot()
ax.legend(locc="best")
plt.show()
```

## ファイルの作成
```python
fig, ax = plt.subplots()
fig.savefig("hogehoge.png")
```

## 棒グラフ
```python
fig, ax = plt.subplots()
x = [...]
y = [...]
labels = [...] #ラベルの名前
ax.bar(x, y, tick_lables=labels)
```

## 散布図
```python
fig, ax = plt.subplots()
x = [...]
y = [...]
ax.scatter(x, y)
plt.show()
```

## ヒストグラム
```python
fig, ax = plt.subplots()
ax.hist(x, bins=25)
plt.show()
```

#### 複数のヒストグラムを重ねる
```python
fig, ax = plt.subplots()
ax.hist((x0, x1, x2), label=["x0", "x1", "x2"], stacked=True)
plt.show()
```

## 箱ひげ図
```python
fig, ax = plt.subplots()
ax.boxplot((x0, x1, x2), labels=["x0", "x1", "x2"])
plt.show()
```

## 円グラフ
```python
fig, ax = plt.subplots()
ax.pie([10, 3, 1], labels=["spam", "ham", "egg"])
plt.show()
```

```
