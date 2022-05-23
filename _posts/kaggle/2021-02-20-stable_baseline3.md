---
layout: post
title: "stable baseline3"
date: 2021-02-20
excerpt: "stable baseline3について"
kaggle: true
hide_from_post: true
tag: ["reinforcement learing", "lib", "stable baseline3"]
comments: false
sort_key: "2021-02-20"
update_dates: ["2021-02-20"]
---

# stable baseline3について
 - 強化学習の便利ライブラリ
 - 特徴
   - pytorchのラッパー
   - 自分でモデル、外部環境を与えることができる

## 各機能の説明

**BaseFeaturesExtractor**
継承してネットワークとモデルを定義する

```python
from stable_baselines3.common.torch_layers import BaseFeaturesExtractor

class MyNN(BaseFeaturesExtractor):
  """
  :param observation: (gym.Space)
  :parma features_dim: (int) Number of features extracted.
  """
  def __init__(self, observation, features_dim):
	super(MyNN, self).__init__(observation_space, features_dim)

	... # パラメータを書く

  def forward(self, x):
	... # ネットワークの接続を書く
```

**Monitor**  
環境を引数にモニター可能な環境を返す  

**DQN**

モデル

```python
model = DQN('NAMING_PARAM', 
			m_env: Monitor, 
			policy_kwargs=policy_kwargs,
            gamma, 
			learning_rate,
            learning_starts, 
			target_update_interval, 
			exploration_fraction, 
			tau
			)

# 学習
model.learn(total_timesteps)
```

## 公式サイトによる例
 - [Examples](https://stable-baselines3.readthedocs.io/en/master/guide/examples.html)
   - 可視化機能が微妙に足りないが、どういったワークフローで学習と推論が行われるか理解できる
