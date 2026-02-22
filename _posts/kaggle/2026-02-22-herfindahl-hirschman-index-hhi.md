---
layout: post
title: "Herfindahl-Hirschman Index HHI"
date: 2026-02-22
excerpt: "市場集中度の指標であるHHIの定義と実装"
project: false
kaggle: true
tag: ["statistics", "economics", "kaggle"]
comments: false
sort_key: "2026-02-22"
update_dates: ["2026-02-22"]
---

# Herfindahl-Hirschman Index HHI

## 概要
 - Herfindahl-Hirschman Index HHI は市場集中度を数値化する指標
 - 企業ごとの市場シェアがわかれば計算できる
 - 1社が独占に近いほど値が大きくなり、多数の企業が均等に競争するほど値が小さくなる
 - Kaggle ではカテゴリ内の売上集中や競合度の特徴量として使いやすい

## 定義
企業 $i$ の市場シェアを $s_i$ とすると、HHI は次で定義される

$$
HHI = \sum_i s_i^2
$$

実装や解釈ではスケールを明確にする
 - $s_i$ を割合で入れる場合、$s_i \in [0, 1]$ なので $HHI \in (0, 1]$
 - $s_i$ を百分率で入れる場合、$s_i \in [0, 100]$ なので $HHI \in (0, 10000]$

均等に $N$ 社が存在する場合の目安
 - 割合スケールでは $HHI = 1 / N$
 - 百分率スケールでは $HHI = 10000 / N$

## 解釈の目安
HHI は国や機関、時代により運用が変わるので、以下は目安として扱う

 - 百分率スケール $0$ から $10000$ の場合
   - $HHI < 1500$ は集中していない
   - $1500 \le HHI < 2500$ は中程度に集中
   - $2500 \le HHI$ は高い集中
 - 割合スケール $0$ から $1$ の場合
   - $HHI < 0.15$ は集中していない
   - $0.15 \le HHI < 0.25$ は中程度に集中
   - $0.25 \le HHI$ は高い集中

## Python 実装
入力を百分率スケールで持つことが多いので、$0$ から $10000$ の HHI を返す関数を用意しておくと扱いやすい

```python
import pandas as pd
import numpy as np

def calculate_hhi(items: list | pd.Series) -> dict:
    """
    リストからHHIおよび正規化HHIを計算する関数
    
    Args:
        items: アイテムの配列（リストまたはPandas Series）
        
    Returns:
        dict: HHI（パーセンテージベース）、HHI（0-1ベース）、正規化HHI
    """
    s = pd.Series(items)
    counts = s.value_counts()
    
    total_n = len(items)
    unique_n = len(counts)
    
    if unique_n == 0:
        return {"hhi_pct": 0.0, "hhi_ratio": 0.0, "normalized_hhi": 0.0}
        
    if unique_n == 1:
        return {"hhi_pct": 10000.0, "hhi_ratio": 1.0, "normalized_hhi": 1.0}

    shares_ratio = counts / total_n
    
    # 1. RatioベースのHHI (0.0 〜 1.0)
    # シェアの2乗和
    hhi_ratio = (shares_ratio ** 2).sum()
    
    # 2. パーセンテージベースのHHI (0 〜 10,000)
    # DOJ/FTCガイドライン等でよく使われるスケール
    hhi_pct = hhi_ratio * 10000
    
    # 3. 正規化HHI (0.0 〜 1.0)
    # ユニークアイテム数(N)への依存を排除し、完全分散時は0、完全集中時は1とする
    # 計算式: (HHI_ratio - 1/N) / (1 - 1/N)
    min_hhi = 1.0 / unique_n
    normalized_hhi = (hhi_ratio - min_hhi) / (1.0 - min_hhi)
    
    return {
        "hhi_pct": round(hhi_pct, 1),
        "hhi_ratio": round(hhi_ratio, 4),
        "normalized_hhi": round(normalized_hhi, 4),
        "unique_items": unique_n,
        "total_items": total_n
    }

if __name__ == "__main__":
    recommendation_output = ['a', 'a', 'a', 'b', 'b', 'c', 'd', 'e']
    results = calculate_hhi(recommendation_output)
    print(f"HHI (0-10000 scale): {results['hhi_pct']}")
    print(f"HHI (0-1 scale):     {results['hhi_ratio']}")
    print(f"Normalized HHI:      {results['normalized_hhi']}")
    print(f"Unique Items:        {results['unique_items']}")
```

