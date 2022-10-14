---
layout: post
title: "lightgbm importance"
date: 2022-10-13
excerpt: "lightgbm importanceのチートシート"
kaggle: true
project: false
tag: ["python", "lightgbm", "importance", "重要度"]
comments: false
sort_key: "2022-10-13"
update_dates: ["2022-10-13"]
---


# lightgbm importanceのチートシート

## 概要
 - splitとgainが選べる
   - split; 分岐数
   - gain; wightの大きさ

## 具体例

```python
fig, ax = plt.subplots(figsize=(30, 10))

lgb.plot_importance(model, importance_type="split", ax=ax)
# gainで見ると非常に大きくなることがあるので、注意
# lgb.plot_importance(model, importance_type="gain", ax=ax)
plt.title('Feature Importance - Model')
plt.show()
```

## 参考
 - [lightgbm.plot_importance](https://lightgbm.readthedocs.io/en/latest/pythonapi/lightgbm.plot_importance.html#lightgbm-plot-importance)
