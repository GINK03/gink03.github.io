---
layout: post
title:  "条件指定可能なRNN"
date:   2017-04-03
excerpt: "一般向け資料、再現性が結構厳しいので、できますよっていうぐらいのレベル"
project: true
tag:
- MachineLearning
- RecurrentNeuralNetwork
- Conditioning
- Emoji
comments: false
---

# RNNのアテンション以外でのアプローチでの条件指定

## はじめに
　Recurrent Neural Networkを私はよく利用するのですが、アテンション以外での方法で条件指定ができずに苦しむことがよくありました。  
　RNNでの表現力は強力で、Encoder-Decoderモデルで発揮されますが、EncoderでRNNの状態を作っても、近視的な視点しか獲得できないことは、各種研究も示しているところです[1]  
　Encoder-Decoderの入力の粒度が例えば単語という粒度であれば、状態を初期化するのに同一の粒度を用いるしかなく、任意の連続系が作れない（漠然とした感情など）という評価を見かけることがありました。 
<p align="center">
  <img alt="アテンションによる重要度の重み付け" width="450px" src="https://cloud.githubusercontent.com/assets/4949982/24601917/b1bc8494-1895-11e7-8580-bcb2de6be7d0.png">
</p>
<div align="center">図1. アテンションによる重要度の重み付け（色が濃いほど重要と言うことだと思う）</div>    

かなり長い間試行錯誤していたモデルがそれなりに上手く行ったので、記録として残していきたいと思います。

## 先行研究
　ググり方が下手なのでよくわかってないですが、私の今回やることはVAE(Variational AutoEncoder)の亜種だとは思います  
　ベイズの定理が成立しているということを前提としています。  
　p(shita|D) = p(D|shita)p(shita)/p(D)
　D：データ点集合
　θ：パラメータ

　GANなどでもよく見る表記ですが、これを視覚的なイメージに置き換えると、  
　z -> x(図で置き換え)
　となり、Zが生成元のデータとなるので、RNNやGANではZの設計がかなり重要です。  

　GANでは評価関数がカルバックライブラー情報量を使うので意識せずとも、p(y\|z)を最大化できます。

## 提案
　RNNではEncoderで入力されたデータxがzを生成していると考えることができそうです。このときややこしいのですが、RNNでは出力した結果を再帰的に自分の次の予想の素性にすることができるので、n-1ステップ時点でのp(y\|z)がnの時点においてq(z\|x)になっており、無理に式に起こすとこのように解釈できそうです。  

```
p_n(p_n-1( p_n-2( p_n-3(.....)))
```
　このような無限の入れ子になっており、以前の文脈から次の文字が決定する文字の生成タスクは非常に相性がよいです。  
　この無限に続きそうな式の最初のパラメータはEncoderの出力q_0なのですが、なんどもこの再帰構造を続けていくと、q_0で指定した値をだんだん忘却してくと感覚的に理解できます(そして実際に忘れていってしまいます)  

　なんとか全体の流れをコントロールできないかとあれやこれややってみたのですが、なかなかうまくいかないです。積みタスクから何度か外そうかと考えていましたが、二週間に一回ぐらいはいじっては玉砕していたのでした。　  
　そこで、もう一段写像関数rを導入します。zの他にもう一つzと同じ働きをするzzというものを定義します。  　  
　p_n(y_n \| z_n)にrを導入すると以下の式のようになる  
```
p_n(y_n | zz_n)
r_n(zz_n| z_n)
q_n(z_n | x_n)
p_n(r_n(p_n-1( r_n-1(p_n-2( r_n-2(p_n-3(.....))))
```
　もう一回層コントローラブルな写像関数rを用意することで、意図的にpの出力をコントロールしようというアプローチです。  
　問題はrの設計なのですが、適応する連続系のドメインで色々とやり方が変わりそうですが、今回はfasttextの分散表現に変換すること、分散表現のベクトルの足し算引き算ができるという、性質を利用して、任意の分散表現の変換を行うことで、意図した文脈を作るアプローチです。  
<p align="center">
<img width="300px" src="https://cloud.githubusercontent.com/assets/4949982/24601940/cb848552-1895-11e7-8bf0-fb9619d41e33.png">
</p>
<div align="center">図2. アノテーションで文脈を変化させることことが、fasttextのエンベッディングを利用することで変えることができる</div>

意味と変換先が対応することで、特定の意味の方向に意識的に意味を近づけることができそう

## 実験方針
KerasでRNNを用いた文字列の作成を行います。  
通常ですと、ワンホットベクトルを利用するか、KerasのEmbeddingを利用しますが、Kerasの標準のEmbeddingは使用しないようにして、代わりに、twitterの400万の投稿をchar levelでfasttextでembeddingを256次元で行います。  
<p align="center">
<img src="https://cloud.githubusercontent.com/assets/4949982/24601959/d9970c64-1895-11e7-86f3-039bf678cb71.png">
</p>
<div align="center">図3. 回帰型ネットワークになるのだが、fasttextによるオペレーションが入るのが特徴的</div>

これでは別段新規性がなさそうなネットワークなのですが、上記で記した写像関数rの役目をfasttextが担っています。これを更に状況を説明しているベクトルを追加します。

## 絵文字による直感的な文脈の変更の説明

<p align="center">
<img src="https://cloud.githubusercontent.com/assets/4949982/24602384/865a4a78-1897-11e7-87eb-e560e214af42.png">
</p>
<div align="center">図4. fasttextと合成可能な演算（絵文字の足し算）をすることで特定の結果に導く</div>

　図のような構成になっており、ノーテションを行うことで文脈を変化させることが可能。ガラス細工的な不安定さも兼ね備えているので、もともとかなり不安定なネットワークであった。
<p align="center">
<img src="https://cloud.githubusercontent.com/assets/4949982/24602457/c8b2dc3c-1897-11e7-9053-0e7f34a1ecd2.png">
</p>
<div align="center">図5. 合成する絵文字を変化させることで任意の文章に変化させることが可能</div>

## 実験結果
　twitterのツイートを絵文字が含まれているものを、絵文字を取り除いて学習する。この際、文章のベクトル化には、二種類のベクトル化を合成した。
<p align="center">
<img src="https://cloud.githubusercontent.com/assets/4949982/24602498/fda18b28-1897-11e7-9176-759923bc2d1e.png">
</p>
<div align="center"> 図6. 試行錯誤のもとの効果的であったベクトルの作り方 </div>

☺をconditional vectorとして文章を生成する場合
*(アスタリスクはパディング文字なので意味はありません)
この文章生成ではマルコフ過程の探索に該当する作業をしていなく、argmaxを利用しています
```sh
*****おはようございます！
```
💧をconditional vectorとして文章を生成する場合
```
*****ごめんなさい！
```
☆をconditional vectorとして文章を生成する場合
```
*****【定期】
```
意図して条件を切り替えるのは、結構難しかったが、なんとか結果を得ることができた。

## Code
　初めてgistを使うなどをしてみた。  
- char levelのfasttextのベクタライズをする様子である
<script src="https://gist.github.com/GINK03/28630674405219fe152fb4d5e92557cb.js"></script>

- term_vector.pklから任意の文字列をRNN入力用のベクタに変換する
<script src="https://gist.github.com/GINK03/e701a4ac81a63e80792a120dd86f6e4a.js"></script>

- modelと、学習部分
<script src="https://gist.github.com/GINK03/6a015233b81a6413bc90d974665fb4d3.js"></script>

## 参考文献
[1] [自然言語処理における、Attentionの耐えられない短さ](http://qiita.com/icoxfog417/items/f170666d81f773e4b1a7)
