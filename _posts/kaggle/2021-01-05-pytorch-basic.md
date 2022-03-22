---
layout: post
title: "pytorch basic"
date: 2021-01-05
excerpt: "pytorchの基本的な使い方"
project: false
config: true
tag: ["python", "pytorch"]
comments: false
---

# pytorchの基本的な使い方"

## 概要
 - pytorchの基本的な文法・演算方法

## numpyからtensorへ変換

```python
x0 = np.random.random(8)
display(x0) # array([0.37519628, 0.96136584, 0.44777695, 0.46619208, 0.5264964 , ...
x1 = torch.from_numpy(x0)
display(x1) # tensor([0.3752, 0.9614, 0.4478, 0.4662, 0.5265, 0.2485, 0.6044, 0.4024], ...
```

## tensorからnumpyへ変換

```python
x1.numpy()
```

## 内積

```python
x1@x1
# または
x1.dot(x1)
```

## clamp(最大と最小でカットオフ)

```python
torch.from_numpy(np.random.random(8)).clamp(0.2, 0.8) # tensor([0.8000, 0.2000, 0.6528, 0.2000, 0.4132, 0.8000, 0.3505, 0.7528],
```

## ノーマライズ

```python
x = torch.from_numpy(np.random.random(8))
display(x) # tensor([0.6519, 0.3942, 0.4390, 0.6562, 0.3268, 0.9316, 0.0103, 0.3475],...
display(F.normalize(x, dim=0)) # tensor([0.4299, 0.2600, 0.2895, 0.4328, 0.2155, 0.6144, 0.0068, 0.2292], ...
```

## unsqueeze
 - 次元を一個増やす操作
 - 引数で外側から何番目の次元について増やすかを指定する

```python
x = torch.from_numpy(np.random.random((3,2)))
display(x)
display(x.unsqueeze(0))
display(x.unsqueeze(1))
display(x.unsqueeze(2))

"""
tensor([[0.1998, 0.6709],
        [0.2513, 0.3640],
        [0.4507, 0.8262]], dtype=torch.float64)
tensor([[[0.1998, 0.6709],
         [0.2513, 0.3640],
         [0.4507, 0.8262]]], dtype=torch.float64)
tensor([[[0.1998, 0.6709]],
        [[0.2513, 0.3640]],
        [[0.4507, 0.8262]]], dtype=torch.float64)
tensor([[[0.1998],
         [0.6709]],
        [[0.2513],
         [0.3640]],
        [[0.4507],
         [0.8262]]], dtype=torch.float64)
"""
```

## repeat
 - 繰り返し

```python
x = torch.from_numpy(np.random.random(3))
x.repeat(3) # tensor([0.2820, 0.8620, 0.5681, 0.2820, 0.8620, 0.5681, 0.2820, 0.8620, 0.5681],
```

## gather
 - 特定のindexの値を代入したマトリックスを作り直す
 - イメージしづらいので小さく実験が必要

```python
t = torch.tensor([[1, 2], [3, 4]])
display(torch.gather(t, 1, torch.tensor([[0, 0], [1, 0]])))
"""
tensor([[1, 1],
        [4, 3]])
"""
display(torch.gather(t, 1, torch.tensor([[1, 0], [0, 0]])))
"""
tensor([[2, 1],
        [3, 3]])
"""
```

