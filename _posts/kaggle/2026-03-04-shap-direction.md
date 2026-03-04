---
layout: post
title: "SHAPの方向性の確認方法"
date: 2026-03-04
excerpt: "SHAPの方向性の確認方法"
project: false
kaggle: true
tag: ["解釈", "lightgbm"]
comments: false
sort_key: "2026-03-04"
update_dates: ["2026-03-04"]
---

# SHAPの方向性の確認方法

## SHAP 方向（符号）の正しい計算
過去に発生したバグ
 - `shap_values.values.mean(axis=0)` の符号を特徴量の「効果方向」として使った結果、特徴量で符号が逆転しているという**偽の結論**を出力した

#### なぜ誤りが起きるか

ブール特徴量（0/1）ではSHAP値の構造が以下のようになる

```
has_boolean_answer = 1 のサンプル: SHAP ≈ +0.15  (true方向に押す)
has_boolean_answer = 0 のサンプル: SHAP ≈ -0.15  (false方向に押す)
```

`mean(axis=0)` は全サンプル（0のサンプルも1のサンプルも）を平均するため次の形になる

```
mean = P(x=1) × (+0.15) + P(x=0) × (-0.15)
```

**x=0 のサンプルが多ければ平均はマイナスになる**  
正の効果を持つ特徴量が負に見える

#### 正しい計算方法

特徴量の「効果方向」は `E[SHAP | feature=high] - E[SHAP | feature=low]` の符号で判断する  
これはbeeswarmプロットの「青い点（feature=high）の位置」に対応する

```python
# ✅ 正しい実装
shap_direction_vals = np.zeros(len(feature_cols))
for i, feat in enumerate(feature_cols):
    feat_vals = X_test[feat].values
    shap_vals_i = shap_values.values[:, i]
    unique_vals = np.unique(feat_vals)

    if len(unique_vals) <= 3:
        # binary / 3値順序 (0/1 or 0/1/2)
        # E[SHAP | x=max] - E[SHAP | x=min]
        mask_hi = feat_vals == unique_vals[-1]
        mask_lo = feat_vals == unique_vals[0]
        if mask_hi.sum() > 0 and mask_lo.sum() > 0:
            shap_direction_vals[i] = shap_vals_i[mask_hi].mean() - shap_vals_i[mask_lo].mean()
        elif mask_hi.sum() > 0:
            shap_direction_vals[i] = shap_vals_i[mask_hi].mean()
    else:
        # 連続値: 上位50% vs 下位50%
        median_val = np.median(feat_vals)
        mask_hi = feat_vals > median_val
        mask_lo = feat_vals <= median_val
        if mask_hi.sum() > 0 and mask_lo.sum() > 0:
            shap_direction_vals[i] = shap_vals_i[mask_hi].mean() - shap_vals_i[mask_lo].mean()

shap_direction = np.sign(shap_direction_vals)
shap_signed = mean_abs_shap * shap_direction  # 符号付き重要度
```

```python
# ❌ 誤った実装（使用禁止）
shap_direction = np.sign(shap_values.values.mean(axis=0))  # boolean特徴量で誤る
```

#### 視覚的な確認

コードで算出した `shap_direction` は必ずbeeswarmと目視で整合チェックすること

 - beeswarmで「青い点（feature=高）が右（正）寄り」→ `shap_direction` は正であるべき
 - beeswarmで「青い点が左（負）寄り」→ `shap_direction` は負であるべき
 - 乖離があれば計算が誤っている

#### 符号逆転レポートの解釈ルール

`sign_match = False` の特徴量を「両モデルで方向が食い違う」と報告する前に：

 1. `shap_signed` の絶対値を確認する  
   - `≈ 0` ならモデルが特徴量をほぼ使っていないだけで逆転ではない
 2. beeswarmを目視して実際の方向を確認する
 3. 真の逆転（`|shap_signed| > 0.01` かつ符号不一致）のみを報告する
