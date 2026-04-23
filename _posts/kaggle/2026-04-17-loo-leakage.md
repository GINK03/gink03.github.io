---
layout: post
title: "LOOにおけるデータリーク"
date: 2026-04-17
excerpt: "LOO CV・LOO Target Encodingで発生するデータリークの構造と対策"
project: false
kaggle: true
tag: ["python", "kaggle", "leakage", "cross validation", "target encoding"]
comments: false
sort_key: "2026-04-17"
update_dates: ["2026-04-17"]
---

# LOOにおけるデータリーク

## 概要
 - LOO（Leave-One-Out）環境でrateなどの統計量を特徴量として使うと、構造的なデータリークが発生しやすい
 - 原因は2層あり、LOO Target Encodingの自己参照リークとLOOCV自体の分布バイアスリークが同時に絡む
 - 小サンプルほど深刻で、CVスコアが良いのに本番で外れる典型的な原因になる

## 問題①: ナイーブなTarget Encodingの自己リーク

カテゴリ変数に全行のターゲット変数の平均（rate）を計算してエンコードすると、その行自身のターゲット値が自分の特徴量に混入する

| 行 | city | clicked (y) | ナイーブなrate |
|---|---|---|---|
| 0 | Tokyo | 1 | (1+0+1)/3 = 0.67 |
| 1 | Tokyo | 0 | (1+0+1)/3 = 0.67 |
| 2 | Tokyo | 1 | (1+0+1)/3 = 0.67 |

行0の特徴量を計算するとき、自分の `y=1` が含まれた状態になる。モデルはトレーニング中に答えをカンニングできるため見かけ上の精度が高くなり、推論時に性能が落ちる

**LOO Target Encodingは解決策にならない**

LOO Target Encodingは自分自身を除いた他行でrateを計算する

```
行0のrate = (Tokyoの合計 - 行0のy) / (Tokyoの件数 - 1)
          = (2 - 1) / 2 = 0.5
```

直接的な自己リークは防げるが、テストデータに適用する際は全件のrateを使うため、train/testで計算方法が非対称になる。またサンプルが少ない場合、除外した1件の影響が残りの値に強く残る

## 問題②: LOOCVの分布バイアスリーク

N件のデータでLOOCVを行うとき、held-outした \(y_j\) と残りのtrain平均は構造的に負の相関を持つ

$$\bar{y}_{train} = \frac{\sum_{i \neq j} y_i}{N-1}$$

つまりモデルが「trainラベルの平均の逆数」を予測するだけで、見かけ上完璧なスコアが出てしまう。Nが小さいほどこのズレは \(\frac{1}{N-1}\) のオーダーで大きくなる

## なぜrateが特に危険か

rateはターゲット変数yそのものを集計した値なので、モデルがrateを参照するだけで実質的にyを参照しているのと同等になる。サンプルが少ない場合、`(全体のrate - 自分のy) / (N-1)` という値は自分のyをほぼ直接反映する

## 対策

| 問題 | 推奨される対策 |
|---|---|
| ナイーブなTarget Encoding | K-Fold内エンコード（fold外データのみ使用） |
| LOO Target Encodingのtrain/test非対称 | sklearn の `TargetEncoder`（K-Fold内で自動処理） |
| 手軽に解決したい | CatBoost Encoding（行を順番に処理し前行のみ参照するため構造的にリーク不可） |
| LOOCVの分布バイアス | 通常のK-Fold CV（foldサイズを大きくして分布差を小さくする） |

## 時系列データの場合

時系列データならTime Series Foldへの切り替えが有効だが、エンコード計算ロジック自体も時系列順にする必要がある

```python
df = df.sort_values("date")

# 悪い例: 全trainデータのrateをtestに適用（非対称）
test["city_rate"] = train.groupby("city")["y"].mean()

# 良い例: 各予測時点より前のデータのみでrate計算
df["city_rate"] = df.groupby("city")["y"].transform(
    lambda x: x.shift(1).expanding().mean()
)
```

## 小サンプルでの現実的な選択

小サンプルではTime Series Foldも機能しないことがある。各foldのtrainが極端に少なくなりモデルが不安定になるため

**統計量を使わない**という選択肢が最も合理的なケースが多い

 - One-hot encoding: カーディナリティが低い変数ならシンプルで安全
 - Ordinal encoding: カテゴリに順序関係がある場合
 - Count encoding: 出現頻度数。ターゲットを参照しないためリークなし
 - ドメイン知識による手動変換: ビジネス的意味を直接数値化

| 条件 | 推奨 |
|---|---|
| 時系列 + サンプル十分 | Time Series Fold + expanding windowでrate計算 |
| 非時系列 + サンプル十分 | K-Fold内エンコード（sklearn `TargetEncoder`） |
| 小サンプル全般 | 統計量特徴量を諦め、One-hotやCount encodingに切り替え |
| カテゴリ変数の処理を自前実装したくない | CatBoostのOrdered Target Encodingに委譲 |

小サンプル環境では「CVスコアと本番性能のギャップを最小化すること」が最優先。高度な手法で見かけ上のスコアを上げるより、シンプルで安全な特徴量設計を選ぶほうが実務的な価値が高い
