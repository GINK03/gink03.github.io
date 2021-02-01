---
layout: post
title: "quadratic weighted kappa"
date: 2021-02-01
excerpt: "quadratic weighted kappa(qwk)というメトリクスについて"
kaggle: true
hide_from_post: true
tag: ["qwk", "metrics", "quadratic weighted kappa", "python"]
comments: false
---

# quadratic weighted kappa(qwk)というメトリクスについて

## 概要
 - `actual`と`pred`の`confusion matric`作成してそれに対して`weight`をかける、というもの  
 - 負の値にもなる
 - 完全に合っているときには`1.0`

## confusion matrics
 - 正解した回数は対角行列に入ることになる  
 - はずしたら、対応するクラスの番号に入る

```python
from sklearn.metrics import confusion_matrix
y_true = [2, 0, 2, 2, 0, 1]
y_pred = [0, 0, 2, 2, 0, 2]

confusion_matrix(y_true, y_pred)

>> array([[2, 0, 0],
       [0, 0, 1],
       [1, 0, 2]])
```

## weight 
 - 別にweightを定義したマトリックスがある
 - 正解の近くのweightは小さく、正解の遠くのweightは大きい

## 具体的なコード

```python
def quadratic_kappa(actuals, preds, N=5):
    """This function calculates the Quadratic Kappa Metric used for Evaluation in the PetFinder competition
    at Kaggle. It returns the Quadratic Weighted Kappa metric score between the actual and the predicted values 
    of adoption rating."""
    w = np.zeros((N,N))
    O = confusion_matrix(actuals, preds)
    for i in range(len(w)): 
        for j in range(len(w)):
            w[i][j] = float(((i-j)**2)/(N-1)**2)
    
    act_hist=np.zeros([N])
    for item in actuals: 
        act_hist[item]+=1
    
    pred_hist=np.zeros([N])
    for item in preds: 
        pred_hist[item]+=1
                         
    E = np.outer(act_hist, pred_hist);
    E = E/E.sum();
    O = O/O.sum();
    
    num=0
    den=0
    for i in range(len(w)):
        for j in range(len(w)):
            num+=w[i][j]*O[i][j]
            den+=w[i][j]*E[i][j]
    return (1 - (num/den))
```

```python
actuals = np.array([4, 4, 3, 4, 4, 4, 1, 1, 2, 0])
preds   = np.array([4, 4, 3, 4, 4, 4, 1, 1, 2, 0])

quadratic_weighted_kappa(actuals, preds)
```

## 参考
 - [What is Quadratic Weighted Kappa?](https://www.kaggle.com/aroraaman/quadratic-kappa-metric-explained-in-5-simple-steps)
