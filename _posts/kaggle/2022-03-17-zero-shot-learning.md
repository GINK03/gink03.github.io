---
layout: post
title: "zero shot learning"
date: 2022-03-17
excerpt: "zero shot learningについて"
kaggle: true
hide_from_post: true
tag: ["statistics", "機械学習", "zero shot learning"]
comments: false
sort_key: "2022-03-17"
update_dates: ["2022-03-17"]
---

# zero shot learningについて"

## 概要
 - 未知のラベルについて予測することができる機械学習
 - NLPでは英語などの言語ですでに用意されている

## 具体例

### flairを用いたzero shot推論

```python
from flair.models import TARSClassifier
from flair.data import Sentence

# 1. Load our pre-trained TARS model for English
tars = TARSClassifier.load('tars-base')

# 2. Prepare a test sentence
sentence = Sentence("I am so glad you liked it!")

# 3. Define some classes that you want to predict using descriptive names
classes = ["happy", "smile", "angry", "sad"]

#4. Predict for these classes
tars.predict_zero_shot(sentence, classes)

# Print sentence with predicted labels
print(sentence)

"""
2022-03-17 15:11:09,869 loading file /home/gimpei/.flair/models/tars-base-v8.pt
Sentence: "I am so glad you liked it !"   [− Tokens: 8  − Sentence-Labels: {'happy-smile-angry-sad': [happy (0.8667), smile (0.5077)]}]
"""
```

## 参考
 - [flair/resources/docs/TUTORIAL_10_TRAINING_ZERO_SHOT_MODEL.md](https://github.com/flairNLP/flair/blob/master/resources/docs/TUTORIAL_10_TRAINING_ZERO_SHOT_MODEL.md)
