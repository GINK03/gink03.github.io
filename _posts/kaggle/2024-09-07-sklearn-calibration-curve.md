---
layout: post
title: "sklearn calibration curve"
date: 2024-09-07
excerpt: "sklearn calibration curveの使い方"
tags: ["python3", "sklearn", "calibration curve"]
kaggle: true
comments: false
sort_key: "2024-09-07"
update_dates: ["2024-09-07"]
---

# sklearn calibration curveの使い方

## 概要
 - sklearnのcalibration_curveを使って、確率予測の正確性を評価できる
 - 予測確率の値と実際の正解ラベルから導かれる確率の値をプロットすることで、予測確率の正確性を評価できる

## サンプルコード

```python
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.calibration import calibration_curve

# キャリブレーションプロットの描画関数
def plot_calibration_curve_seaborn(y_true, y_pred_prob, n_bins=10):
    # キャリブレーションカーブを計算
    fraction_of_positives, mean_predicted_value = calibration_curve(y_true, y_pred_prob, n_bins=n_bins)

    # seabornを使用してプロット
    plt.figure(figsize=(8, 6))
    sns.lineplot(x=mean_predicted_value, y=fraction_of_positives, marker='o', label='モデルのキャリブレーションカーブ')
    
    # 完全なキャリブレーションモデルの対角線
    sns.lineplot(x=[0, 1], y=[0, 1], linestyle="--", color="black", label="完全なキャリブレーション")
    
    # 軸ラベルとタイトル
    plt.xlabel("予測確率")
    plt.ylabel("実際の正例の割合")
    plt.title("キャリブレーションプロット")
    plt.legend()
    plt.grid(True)
    plt.show()

# 例として、y_trueとy_pred_probを使用
y_true = np.array([0, 1, 1, 0, 1, 0, 1, 0, 1, 1])
y_pred_prob = np.array([0.1, 0.8, 0.9, 0.4, 0.95, 0.3, 0.85, 0.2, 0.9, 0.7])

plot_calibration_curve_seaborn(y_true, y_pred_prob)
```

<div align="center">
  <img src="https://f004.backblazeb2.com/file/gimpeik/Images-2024/Screenshot+2024-09-07+at+10.27.39.png" alt="calibration_curve">
</div>
