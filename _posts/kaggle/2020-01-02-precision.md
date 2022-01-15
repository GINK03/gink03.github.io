---
layout: post
title: "precision"
date: 2020-01-02
excerpt: "precisionについて"
kaggle: true
hide_from_post: true
tag: ["statistics", "precision", "metric"]
comments: false
---

# precision

## 数式

$$
Precision = \frac{TP}{TP +FP}
$$

## sklearn

```python
from sklearn.metrics import precision_score
precision_score(y_true, y_pred > th)
```
