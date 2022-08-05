---
layout: post
title: "Variance Inflation Factor(VIF)"
date: 2022-08-05
excerpt: "Variance Inflation Factor(VIF)について"
kaggle: true
tag: ["機械学習", "VIF", "Variance Inflation Factor", "線形重回帰", "多重共線性"]
sort_key: "2022-08-05"
update_dates: ["2022-08-05"]
comments: false
---

# Variance Inflation Factor(VIF)について

## 概要
 - 線形重回帰などで問題になる多重共線性の大きさを測定する指標
 - 変数間の相関係数行列を作成し、操作することで得られる
 - 一般的に、VIFの値が10を超えたら調整する必要があると言われている

## ライブラリを使用した算出例

```python
import pandas as pd 
from statsmodels.stats.outliers_influence import variance_inflation_factor


data = pd.read_csv('BMI.csv')
data['Gender'] = data['Gender'].map({'Male':0, 'Female':1})
X = data[['Gender', 'Height', 'Weight']]

vif_data = pd.DataFrame()
vif_data["feature"] = X.columns
vif_data["VIF"] = [variance_inflation_factor(X.values, i) for i in range(len(X.columns))]
```

**出力**  
```csv
feature        VIF
Gender    2.028864
Height   11.623103
Weight   10.688377
```

## 参考
 - [VIF/統計用語集](https://bellcurve.jp/statistics/glossary/2141.html)
 - [Detecting Multicollinearity with VIF – Python](https://www.geeksforgeeks.org/detecting-multicollinearity-with-vif-python/)
 - [VIF統計量をPythonで計算](https://betashort-lab.com/%E3%83%87%E3%83%BC%E3%82%BF%E3%82%B5%E3%82%A4%E3%82%A8%E3%83%B3%E3%82%B9/%E7%B5%B1%E8%A8%88%E5%AD%A6/python%E3%81%A7vif-variance_inflation_factor/)
