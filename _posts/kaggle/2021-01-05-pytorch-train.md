---
layout: post
title: "pytorch train"
date: 2021-01-05
excerpt: "pytorchのtrain, validationの使い方"
project: false
tag: ["python", "pytorch", "train", "validation"]
comments: false
sort_key: "2022-03-22"
update_dates: ["2022-03-22"]
---

# pytorchのtrain, validationの使い方

## 概要
 - pytorchでのtrainの使い方

## 基本的な使用方法
 1. numpyのシードを固定
 2. [/optimizer/](/pytorch-optimizer/)を初期化
 3. (option) 微分方法を選択
 4. 損失関数を初期化
 5. バッチイタレーションを開始
   1. オプティマイザをzero gradへ設定
   2. データを推論
   3. 損失を計算
   4. backwardを計算
   5. オプティマイザのステップを進める
   6. バリデーション

## 例

### minimal example of train

```python
np.random.seed(123) # シードを固定
optimizer = get_optimizer(model) # optimizerを初期化
criterion = torch.nn.BCEWithLogitsLoss() # 損失関数を初期化
for epoch in range(epochs):
    model.train()
    lr = adjust_lr(optimizer, epoch)
    for (X, y) in train_loader: # dataloaderでbatchを回す
        optimizer.zero_grad() # zero_gradに設定
        y_hat = model(X) # 推論
        loss = criterion(y_hat, y) # 損失を計算
        loss.backward() # 誤差伝搬
        optimizer.step() # 学習
    validation(model)
```

### minimal example of validation

```python
def validation(model):
    model.eval()
    y, y_hat = [], []
    with torch.no_grad():
        for X, y_tmp in validation_dataloader:
            y_tmp = y_tmp.detach().cpu().numpy()
            y_hat_tmp = model(X)
            y_hat_tmp = y_hat_tmp.detach().cpu().numpy()
            y.extend(y_tmp.tolist())
            y_hat.extend(y_hat_tmp.tolist())
    score = roc_auc_score(y, y_hat)
```
