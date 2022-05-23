---
layout: post
title: "gausian mixture"
date: 2021-01-30
excerpt: "gaussian mixtureモデルの特性とその使い方"
kaggle: true
hide_from_post: true
tag: ["feature", "gaussian mixture", "python"]
comments: false
sort_key: "2021-02-01"
update_dates: ["2021-02-01"]
---

# gaussian mixtureモデルの特性とその使い方
ガウス混合モデルにフィットしてどのガウス分布から生成されたかを推論するモデル

## 2峰のガウス分布から生成されていると仮定し、それを推論するモデル

```python
from sklearn.mixture import GaussianMixture

gmm = GaussianMixture(n_components=2, random_state=42)

gmm.fit(something_numpy_array)

classfied_value = gmm.predict(something_numpy_array)
```
