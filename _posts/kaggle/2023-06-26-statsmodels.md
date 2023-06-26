---
layout: post
title: "python statsmodels" 
date: 2023-06-26
excerpt: "python statsmodelsの使い方"
kaggle: true
tag: ["kaggle", "統計", "python", "statsmodels"]
comments: false
sort_key: "2023-06-26"
update_dates: ["2023-06-26"]
---

# python statsmodelsの使い方

## 概要
 - pythonパッケージにRの分析の強みを持ち込もうとして作成されたライブラリ
 - 出力もRの出力に似ている
 - 切片を有効にしたときにp値のリストの並び順は切片からになる

## 機能
 - 線形回帰
 - ロジスティック回帰
 - ARIMA
 - ANOVA
 - 統計的仮説検定
 - 一般線形モデル(GLM)
 - 生存分析

## 線形モデルの例

```python
import statsmodels.api as sm
import numpy as np

# 例として、XとYのサンプルデータを生成
X = np.random.random(100)
Y = 3 * X + np.random.normal(0, 0.2, 100) 

# 線形回帰モデルをフィット。statsmodelsでは、切片を含めるために定数項を追加する必要がある
X = sm.add_constant(X)
model = sm.OLS(Y, X).fit()

# 結果の要約を表示。これには、決定係数、調整済み決定係数、および統計的検定の結果が含まれる
print(model.summary())

# p値の表示
p_value_constant = model.pvalues[0]
p_value_x0 = model.pvalues[1]
print(p_value_x0, p_value_constant)
"""
                            OLS Regression Results                            
==============================================================================
Dep. Variable:                      y   R-squared:                       0.935
Model:                            OLS   Adj. R-squared:                  0.934
Method:                 Least Squares   F-statistic:                     1399.
Date:                Mon, 26 Jun 2023   Prob (F-statistic):           8.13e-60
Time:                        02:02:41   Log-Likelihood:                 3.8648
No. Observations:                 100   AIC:                            -3.730
Df Residuals:                      98   BIC:                             1.481
Df Model:                           1                                         
Covariance Type:            nonrobust                                         
==============================================================================
                 coef    std err          t      P>|t|      [0.025      0.975]
------------------------------------------------------------------------------
const          0.0345      0.045      0.759      0.450      -0.056       0.125
x1             3.0108      0.081     37.397      0.000       2.851       3.171
==============================================================================
Omnibus:                        4.917   Durbin-Watson:                   2.177
Prob(Omnibus):                  0.086   Jarque-Bera (JB):                4.246
Skew:                           0.438   Prob(JB):                        0.120
Kurtosis:                       3.501   Cond. No.                         4.28
==============================================================================

Notes:
[1] Standard Errors assume that the covariance matrix of the errors is correctly specified.
8.128881695464988e-60 0.44976460059264567
"""
```
