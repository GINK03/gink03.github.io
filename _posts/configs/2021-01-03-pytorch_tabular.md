---
layout: post
title: "deep learning tabular"
date: 2021-01-03
excerpt: "pytorchでtabularデータを学習&推論する"
tags: ["deep learning", "tabular", "pytorch"]
comments: false
---


# pytorchでtabularデータを学習&推論する
 - deep learningでtabularデータを扱う

## 参考
 - [A Neural Network in PyTorch for Tabular Data with Categorical Embeddings](https://yashuseth.blog/2018/07/22/pytorch-neural-network-for-tabular-data-with-categorical-embeddings/)
 - [pytorch-tabular/pytorch_tabular.py](https://github.com/yashu-seth/pytorch-tabular/blob/master/pytorch_tabular.py)

## 実装したもの
 - [psyche/PytorchTabular.py](https://github.com/GINK03/psyche/blob/master/PytorchTabular.py)

## 説明
 - pandasのデータをpytorchでdnnする
 - `TabularDataset`, `FeedForwardNN`クラス

*DataLoader*
```python
dataset = TabularDataset(
		  data=data[col_x + col_y], 
		  cat_cols=categorical_features, # pandasのcategorical featの名前
		  output_col=col_y # yは複数でも良い)
dataloader = DataLoader(dataset, batchsize, shuffle=True, num_workers=1)
```

*FeedForwardNN*
```python
model = FeedForwardNN(
	emb_dims=[], # embeddingしたいとき、tupleで指定する
    no_of_cont=8, # 連続変数の数
	lin_layer_sizes=[80, 80, 80], # 中間層のネットワークの数
	output_size=11, # 出力サイズ
	emb_dropout=0.04, # embeddingのレイヤーのドロップアウトレート
    lin_layer_dropouts=[0.001, 0.01] # 中間層のドロップアウトレート
	).to(device)
```
