---
layout: post
title:  "novel recommend"
date:   2020-10-28
excerpt: "novel recommend"
project: true
tag: ["novel", "recommend"]
comments: false
---

# Tweetの #名刺代わりの小説10選 から機械学習を使わずレコメンド

## 導入・目的

Twitterでは`#名刺代わりの小説10選`というタグが存在し、2018 ~ 2020/10/25までにおおよそ[8000ツイート](https://github.com/GINK03/novel_recommend/blob/master/var/shosetsu_dataset.csv)をちまちまと集めることができました。    

このタグから、レコメンドを行いたいと思います。データ数的に、[けんすうさんが制作したMNM](https://kensuu.com/n/n58dfb5fc02e7)ほどデータを集めることができなかったので、機械学習のアプローチを用いずにスモールデータでもワークするアプローチでレコメンドを行いたいと思います。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/%E5%90%8D%E5%88%BA%E4%BB%A3%E3%82%8F%E3%82%8A%E3%81%AE%E5%B0%8F%E8%AA%AC10%E9%81%B8?src=hash&amp;ref_src=twsrc%5Etfw">#名刺代わりの小説10選</a><br>未来のイヴ/リラダン<br>ライ麦畑でつかまえて/サリンジャー<br>アルジャーノンに花束を/ダニエル・キイス<br>箱男/安部公房<br>砂の女/同上<br>風の歌を聴け/村上春樹<br>羊をめぐる冒険/同上<br>スプートニクの恋人/同上<br>海と毒薬/遠藤周作<br>機械の中の幽霊/ケストラー</p>&mdash; てでーべあー (@kumanikamareru) <a href="https://twitter.com/kumanikamareru/status/1318177175594467328?ref_src=twsrc%5Etfw">October 19, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


## 方法
どんなレコメンドであっても基本は共起を用いたアプローチを取ることが多いです。これは行列分解を行うMatrix Factorizationなどや類似のアルゴリズムは共起を基本としたアルゴリズムほとんどに言うことができます。  

一般には機械学習をベースとしたアプローチが主流ですが、次元圧縮等を伴わない場合(つまり、汎化を気にしない場合)、テーブル操作のみで同等のことが行えます。  

`#名刺代わりの小説10選`のツイート構造が好きな10冊の本のタイトルを紹介するもので、ある一冊に着目し、周辺に共起となるタイトルが散らばっていると考えることができます。  

<div align="center">
  <img style="width: 320px !important;" src="https://user-images.githubusercontent.com/4949982/97434326-31ec6f00-1962-11eb-923b-500306ec8722.png">
</div>

あるタイトルの周辺に散らばっているタイトルをうまく集計していくことで、どのような本がある本の近くに現れやすいのかを定量化することができます。  

#### 前処理

ツイートは自然言語で記述されており、基本は`"本のタイトル"/"著者"`で構成されていますが、例外も多く、`『』`でタイトルや本が指定されているもの、`|`で分画されているもの、タイトルと著者が逆転しているものと様々です。  
基本的にはヒューリスティックにそこそこパースできるプログラムを目指すのですが、以下のようなコードになってしまいます。 

```python
import re
import mojimoji


total = []
for tweet in df["tweet"]:
    if not isinstance(tweet, str):
        continue
        
    block = []
    tweet = mojimoji.zen_to_han(tweet, kana=False)
    for line in tweet.split("\n"):
        line = line.strip()
        if "#" in line:
            continue
        if line == "":
            continue
        
        if "「" in line and "」" in line:
            a = re.search("「(.*?)」", line).group(1)
            b = re.sub("「.*?」", "", line)
            block.append(a)
            block.append(b)
        elif "『" in line and "』" in line:
            a = re.search("『(.*?)』", line).group(1)
            b = re.sub("『.*?』", "", line)
            block.append(a)
            block.append(b)
        elif "(" in line and ")" in line:
            a = re.search("\((.*?)\)", line).group(1)
            b = re.sub("\(.*?\)", "", line)
            block.append(a)
            block.append(b)
        elif "/" in line and line.count("/") == 1:
            a, b = line.split("/")
            block.append(a)
            block.append(b)
        elif "|" in line and line.count("|") == 1:
            a, b = line.split("|")
            block.append(a)
            block.append(b)
        elif re.split("\s{1,}", line).__len__() == 2:
            a, b = re.split("\s{1,}", line)
            block.append(a)
            block.append(b)
        else:
            pass
    total.append([x.strip() for x in block])
```

精度は64%で、64%のツイートでパースすることに成功しました。

#### 著者情報
また、[Wikipediaの小説家一覧](https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E5%B0%8F%E8%AA%AC%E5%AE%B6%E4%B8%80%E8%A6%A7)より、小説家をすべて定義します。そうすることで、タイトルだけをユニークに取り出すことができ、著者とタイトルを分離できます。

```python
# 著者の名前が記されたcsvを読み込み
names = pd.read_csv("var/auths.csv")["name"].tolist()
# titleの抽出
total = [[x for x in block if x not in names and x in titles ] for block in total ] 
total = [x for x in total if x.__len__() >= 1]
```

#### 人気の本、著者
本筋からはずれますが、みなさんがよく上げる10冊の中にあるタイトルには、以下のようなタイトルがあることが分かりました。  

<div align="center">
  <img style="width: 200px !important;" src="https://user-images.githubusercontent.com/4949982/97427717-53485d80-1958-11eb-9544-bc413a12e8da.png">
</div>

この中からだと、私は`星の王子さま`と`虐殺器官`が好きです。  

また作家ランキングだと以下のようになります。 

<div align="center">
  <img style="width: 200px !important;" src="https://user-images.githubusercontent.com/4949982/97428026-c18d2000-1958-11eb-8230-c59833eac48e.png">
</div>


#### 共起を計算する

`total`というlistを共起するタイトルを`title_cos` 変数の中にどんどん追加していき、すべて追加し終わったあとに、最大値で割り込むことでnormalizeした各タイトル(title)ごとに共起しやすいタイトル(co)を一覧で表現することができます。  

```python
title_cos = {}

for block in total:
    for title in block:
        title_cos[title] = title_cos.get(title, []) + block

tmps = []
for title, cos in list(title_cos.items()):
    cos = Counter(cos)
    max_ = max(cos.values())
    tmp = pd.DataFrame({"co": list(cos.keys()), "val": list(cos.values())})
    tmp["title"] = title
    tmp = tmp[tmp.val >= 2]
    tmp["val"] /= max_
    tmps.append(tmp.sort_values(by=["val"], ascending=False)[:300])
    #print(title)
ret = pd.concat(tmps)
ret = ret[["title", "co", "val"]]
ret
```

例えば、`夜は短し歩けよ乙女`を見てみるとそれらしく出ています。  
<div align="center">
  <img style="width: 300px !important;" src="https://user-images.githubusercontent.com/4949982/97429029-2d23bd00-195a-11eb-9e8b-0207f0e8c2b7.png">
</div>

#### 頻出するものは重要でない仮説を導入する

自然言語処理などでよく使われる理論に`tfidf`等が存在しますが、`idf`部分はレアリティが高いものを高いスコアに、頻出するものは低いスコアにするヒューリスティックです。  
この仮説は割とどこでも適応可能で、今回のようなケースにも実際に適応可能でした。 

具体的にはTOP 300以内によく登場する本はあまり重要でない仮説を導入します。

```python
w = ret.groupby(by=["co"]).agg(val_sum=("val", "sum")).reset_index()
df = pd.merge(ret, w, on=["co"], how="left")

df["val_norm"] = df["val"]/np.log(df["val_sum"]+np.e)

tmps = []
for title, s in df.groupby(by=["title"]):
    tmps.append(s.sort_values(by=["val_norm"], ascending=False))
    
df = pd.concat(tmps)
```

その上で、`夜は短し歩けよ乙女`を見てみると微妙に内容的に遠いのでは？と考えていた、`図書館戦争`や`人間失格`が有名だから共起していましたが、この改良版ではランクが下がりました。  

<div align="center">
  <img style="width: 300px !important;" src="https://user-images.githubusercontent.com/4949982/97430238-ee8f0200-195b-11eb-9747-f3a0637aa326.png">
</div>

## 結果

作家の粒度でも簡単に実行でき、村上春樹だと以下のようになります。
<div align="center">
  <img style="width: 300px !important;" src="https://user-images.githubusercontent.com/4949982/97430689-9c021580-195c-11eb-9e4d-d44a95cecd62.png">
</div>

[Google Spreadsheetで誰でも見れるようにおいてある](https://docs.google.com/spreadsheets/d/16tQKGsL64iOLTr8wR9Ilwwp6JyxS7JyzwC0U2XhYkKU/edit?usp=sharing)のでご自身の好きなタイトルや作家さんを探してみましょう(作者名フィルタで落としきれなかったノイズも多少あり、これは手動でフィルタを追加するしかなさそうです)   

私は`ハーモニー`に関連する本をいくつか読んで自分で定性的に評価したのですが、かなり良かったです。`紫色のクオリア`とか`淵の王`とはちゃんと出るのは良さがあります。  

## 考察
データ数がそんなになくとも、pandasでデータをゴニョゴニョしてテーブル操作するだけで、割とまともな結果を得ることができました。  

MatrixFactorizationなどをこのような課題設定で使うことも可能なのですが、そのまま適応してしまうと、メジャーなタイトルに寄せられてしまう問題やハイパラであるどういう性質がある本にどういう割引を行うか、などを機械学習のブラックボックス性故に少し感覚値がつかみにくいなどがあります。しかし、今回の方法だと目で見て感覚を掴みながら調整できるので、どのへんが良さそうなのかすぐ探索できます。    

## まとめ
個人でさっとバズったTwitterのハッシュタグを集めて分析して、自分のQoLを上げるのは良さそうです。　

今回、集めた8000近くのツイートやjupyterのクソコード等はGitHubで公開していますので、ご自由にどうぞ。。。

 - [GitHub](https://github.com/GINK03/novel_recommend)
