---
layout: post
title:  "pytorch model"
date:   2021-01-05
excerpt: "pytorchのmodelの使い方"
project: false
tag: ["python", "pytorch"]
comments: false
---

# pytorchのmodelの使い方

## 概要
 - pytorchでのモデルの作成方法

## 基本的な使用方法
 1. `nn.Module`を継承する
 2. `__init__`で基底クラスのコンストラクタを呼び出す
 3. `__init__`で状態を記録するパラメータ(nnの重みや係数)を初期化する
 4. `forward`でデータの流れを定義する
   - forwardの引数はtupleで与える

## 各レイヤーの説明

### 全結合層(fully connected)

```python
nn.Liner(input_size, output_size)
```

### Embedding

```python
nn.Embedding(num_embeddings, embedding_dim)
```
 - `num_embeddings`; インプットする要素数
 - `embedding_dim`; embedした際の次元

**embeddingレイヤーの重み**  
```python
padding_idx = 0
embedding = nn.Embedding(3, 4, padding_idx=padding_idx)
embedding.weight
"""
Parameter containing:
tensor([[ 0.0000,  0.0000,  0.0000,  0.0000],
        [ 1.6259,  1.2915,  3.1323, -1.1606],
        [-0.8106,  1.3287,  0.4649, -0.5580]], requires_grad=True)
"""
```

### Conv1d

```python
nn.Conv1d(in_channels, out_channels, kernel_size)
```
 - `(N, C_{in_channels}, L) == (N, C_{out_channels}), L_out)`の関係が成立する
   - N; バッチサイズ
   - C; チャンネル　
   - L; 連続するシグナル
 - 参考
   - [CONV1D](https://pytorch.org/docs/stable/generated/torch.nn.Conv1d.html)
   - [/cnn/](/cnn/)


## 最小構成例

### モデルの定義

```python
class UserModel(nn.Module):
    def __init__(self):
        super(UserModel, self).__init__() # 基底クラスの初期化
        
        self.emb0 = nn.Embedding(100, embedding_dim=100)
        self.emb1 = nn.Embedding(100, embedding_dim=100)
        self.seq = nn.Sequential(nn.Conv1d(3, 32, kernel_size=1), nn.LeakyReLU(),
                                 nn.Conv1d(32, 8, kernel_size=1), nn.LeakyReLU(),
                                 nn.Conv1d(8, 1, kernel_size=1))
        
    def forward(self, inputs):
        t0, t1 = inputs[0], inputs[1] # 引数はtupleでまとめる
        x0 = self.emb0(t0)
        x1 = self.emb1(t1)
        x = torch.concat([x0, x1])
        x = F.normalize(x, dim=2)      
        x = self.seq(x).squeeze(1)
        return x
```

### インスタンス化

```python
model = UserModel()
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu") 
model.to(device)
```

### モデルの保存

```python
path = "./model.pth" 
torch.save(model.state_dict(), path) 
```

### モデルをファイルから復元

```python
path = "./model.pth" 
models.load_state_dict(torch.load(path))
```
