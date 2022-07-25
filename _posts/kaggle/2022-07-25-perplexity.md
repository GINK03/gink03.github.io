---
layout: post
title: "perplexity"
date: 2022-07-25
excerpt: "perplexityについて"
kaggle: true
tag: ["機械学習", "perplexity"]
sort_key: "2022-07-25"
update_dates: ["2022-07-25"]
comments: false
---

# perplexityについて

## 概要
 - NLPなどで使われるその文章がどの程度の妥当性があるかを判定する指標
 - perplexityはエントロピーを用いて計算される
   - 確率分布に偏りが大きければ小さい値になる

## 定義

$$
PP(x) :=  2^{H(p)} = 2^{-\sum p(x) \log_2p(x)} = \prod p(x)^{-p(x)}
$$

## GTP-2で文章のperplexityを計算する

```python
import torch
import sys
import numpy as np

from transformers import GPT2Tokenizer, GPT2LMHeadModel
# Load pre-trained model (weights)
with torch.no_grad():
        model = GPT2LMHeadModel.from_pretrained('gpt2')
        model.eval()
# Load pre-trained model tokenizer (vocabulary)
tokenizer = GPT2Tokenizer.from_pretrained('gpt2')

def score(sentence):
    tokenize_input = tokenizer.encode(sentence)
    tensor_input = torch.tensor([tokenize_input])
    loss=model(tensor_input, labels=tensor_input)[0]
    return np.exp(loss.detach().numpy())

if __name__=='__main__':
    for line in sys.stdin:
        if line.strip() !='':
            print(line.strip()+'\t'+ str(score(line.strip())))
        else:
            break
```

**実行例**  
```console
$ printf "I am tanaka.I love ramen.I am living in Tokyo.\nI am yamada.I love ramen.\nI am kobayashi.I love sushi." | python3 test.py
I am tanaka.I love ramen.I am living in Tokyo.  88.73084
I am yamada.I love ramen.       213.50696
I am kobayashi.I love sushi.    162.70877
```
 - 妥当そうな文章のほうが低い値となる

## 参考
 - [Perplexity/Wikipedia](https://en.wikipedia.org/wiki/Perplexity)
 - [Comparing BERT and GPT-2 as Language Models to Score the Grammatical Correctness of a Sentence](https://www.scribendi.ai/comparing-bert-and-gpt-2-as-language-models-to-score-the-grammatical-correctness-of-a-sentence/)
