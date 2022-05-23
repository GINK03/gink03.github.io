---
layout: post
title: "pytorch optimizer"
date: 2021-01-05
excerpt: "pytorchのoptimizerの使い方"
project: false
tag: ["python", "pytorch", "optimizer"]
comments: false
sort_key: "2022-03-22"
update_dates: ["2022-03-22"]
---

# pytorchのoptimizerの使い方

## 概要
 - pytorchでのoptimizerの使い方

## 基本的な使用方法
 - トレーニング時に各層のトレイン可能なものをオプティマイザの引数に与える
 - 必要に応じてlearning rateを更新する

## 例

### Adam Optimizerの具体例

```python
def get_optimizer(model):
    optimizer = torch.optim.Adam(filter(lambda p: p.requires_grad, model.parameters()), 
                                  lr=1e-4, 
                                  betas=(0.9, 0.999),
                                  eps=1e-08)
    return optimizer
```

### epoch毎にlearning rateを更新する例

```python
def adjust_lr(optimizer, epoch: int) -> None:
    if epoch < 1:
        lr = 1e-5
    elif epoch < 6:
        lr = 1e-3
    elif epoch < 9:
        lr = 1e-4
    else:
        lr = 1e-5
    for p in optimizer.param_groups:
        p['lr'] = lr
    return None
```
