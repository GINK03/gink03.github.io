---
layout: post
title: "lightweight mmm"
date: 2022-10-18
excerpt: "lightweight mmmの使い方"
kaggle: true
project: false
tag: ["mmm", "marketing mix modeling"]
comments: false
sort_key: "2022-10-18"
update_dates: ["2022-10-18"]
---


# lightweight mmmの使い方

## 概要
 - ベイズのベースのMMMモデリングソフトウェア
 - 事前分布を初期化するときの引数で与えられるので、これを用いると学習の値が安定する
   - 料金と成果が比例するという暗黙の仮定を組み込める

## インストール
 - (macosでは)依存の解決が難しい
 - poetryなどで仮想環境を構築したあと、force installすると入る
   - 依存は手動解決

```console
$ poetry init
$ poetry shell
$ python3 -m pip install --upgrade --no-deps --force-reinstall lightweight_mmm
```

## 具体例

```python
from lightweight_mmm import preprocessing, lightweight_mmm, plot, optimize_media
import jax.numpy as jnp

# impression等
media_scaled      = preprocessing.CustomScaler(divide_operation=jnp.mean).fit_transform(media)
# 目的変数
target_scaled     = preprocessing.CustomScaler(divide_operation=jnp.mean).fit_transform(target)
# 投資したコスト等
costs_scaled      = preprocessing.CustomScaler(divide_operation=jnp.mean).fit_transform(costs)
mmm = lightweight_mmm.LightweightMMM(model_name="hill_adstock")
mmm.fit(
        media       = media_scaled,
        media_prior = costs_scaled,
        target      = target_scaled,
        number_warmup=500, # 1000
        number_samples=500, # 1000
        number_chains=1,
        degrees_seasonality=1,
        weekday_seasonality=True,
        seasonality_frequency=365,
        seed=1)

effect_hat, roi_hat = mmm.get_posterior_metrics()
rf = pd.DataFrame()
rf["media_name"] = columns
rf["effect_hat"] = media_effect_hat.mean(axis=0)
rf["roi_hat"] = roi_hat.mean(axis=0)
rf.sort_values(by=["effect_hat"], ascending=False)
```

---

## 参考
 - [google/lightweight_mmm](https://github.com/google/lightweight_mmm)
   - github
 - [How To Create A Marketing Mix Model With LightweightMMM](https://forecastegy.com/posts/how-to-create-a-marketing-mix-model-with-lightweightmmm/)
   - サンプルデータと具体的な学習例
 
