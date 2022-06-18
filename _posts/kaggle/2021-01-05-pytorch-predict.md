---
layout: post
title: "pytorch predict"
date: 2021-01-05
excerpt: "pytorchのpredictの使い方"
project: false
tag: ["python", "pytorch"]
comments: false
sort_key: "2022-03-22"
update_dates: ["2022-03-22"]
---

# pytorchのpredictの使い方

## 概要
 - pytorchでのpredictの使い方
 - 学習と同じIFを用いていると推論プロセスを走らせる度に、GPUメモリを確保してしまうので、ちょっとしたテクニックが必要
 - batchサイズも重要でGPUの使用率をできるだけ高く使う設定が最も推論が早くなる
   - `nvidia-smi -1`でリソースを確認できる

## 具体例

**メモリを毎回確保してしまう事がある例**  
```python
predict = model.predict(X)
```

**no_gradを指定し、学習を止めてメモリを確保しない例**  
```python
import gc
import torch
with torch.no_grad():
    predict = model.predict(X)
gc.collect()
torch.cuda.empty_cache()
```

## 参考
 - [CUDA out of memory when using model to make predictions](https://discuss.pytorch.org/t/cuda-out-of-memory-when-using-model-to-make-predictions/39002)
