---
layout: post
title:  "Kotlin JSoup Selenium PhantomJS Scraper"
date:   2017-04-10
excerpt: "Kotlin版scraper"
project: true
tag:
- MachineLearning
- Kotlin
comments: false
---

# まずはここを参照
https://github.com/GINK03/kotlin-phantomjs-selenium-jsoup-parser

# 🔱Kotlinによるスクレイピング🔱
<p align="center">
<img width="400px" src="https://cloud.githubusercontent.com/assets/4949982/24857060/e07de264-1e21-11e7-82d5-b14c552058af.jpg">
</p>
<div align="center">図1. 艦これの画像をKotlinでスクレイピングした画像で作った阿武隈のモザイクアート</div>

## PythonからKotlinへ部分的な移行@機械学習エンジニアの視点
　Pythonは便利な言語です。しかし、スクリプト言語で型を厳密に評価しないということと、いくつかの高負荷な操作において、うまく行かないことがあります。
　個人的な経験によるものですが、分析対象が巨大になり、より並列性が求められるプログラムにおいては、Pythonの再現性のないエラーについて悩まされることが多かったです。
　何気なく触ってみたKotlinは結構使いやすく、Python3で実装していたScraperを移植してみました。  
　(なお、私はJavaをろくに触ったことがないです)

## Pythonのthreadとmultiprocessをつかったスクレイパー

<p align="center">
<img width="400px" src="https://cloud.githubusercontent.com/assets/4949982/24857508/87e946b4-1e23-11e7-82e7-50b7be51f813.png">
</p>
<div align="center"> 図2. ずっとPythonで使ってたScraperのアクセス方式 </div>
PythonではマルチプロセスとThreadは区別されており、Threadはマルチコアにならないです(1CPUしか使えないのでこの細工がいる)。

Kotlinニュービーなのですが、PythonのthreadとKotlinのthreadは動作が違うように見えます。  
KotlinのThreadではプロセスが分割しないのに、CPUの使用率が100%を超えるため、複数CPUを使った効率的なThreadingが行われているようです。(つまり、Multiprocessで分割したあと、Threadを配下で実行する必要がなさそう)

## Kotlinのインストール
Ubuntuでのインストールの方法です。
```sh
$ curl -s https://get.sdkman.io | bash
$ sdk install kotlin
```

## メモリを増やす
環境変数JAVA_OPTにJVMのメモリが記されているらしく、普通に使うと、メモリ不足で落ちるので、今風になおしておいたほうがいいでしょう。
わたしはこのような設定にしています。
```sh
JAVA_OPTS="-Xmx3000M -Xms3000M"
```

## CUIでのコンパイル&実行のしかた
　わたしはJavaが苦手で、Javaを極力避けるようなキャリアプランを歩もうと思っていたのですが、それは主にエクリプスやIDEやらのツール自体の学習コストが多いように感じていて、つらいと思うことが多かったからです。  
　KotlinもIDEを使えば便利なのですが、CUIでコンパイル＆実行で問題が生じない限りはCUIでいいやと思っています。  
　コンパイルには、いろいろあるのですが、runtimeを含めて、jarファイルに固めてしまうのがユーザビリティ高めでした。
```sh
$ kotlinc foo.kt -include-runtime -d foo.jar
```
　これでコンパイルができます。  
　複数のファイルをまとめてjarにすることができます。(foo.ktでbar.ktの関数やClassを参照できます)
```sh
$ kotlinc foo.kt bar.kt -include-runtime -d foo.jar
```
　JavaのMavenなどでコンパイルして得ることができるjarファイルをclasspathに追加することで利用可能です。 (alice.jar, bob.jarというファイルを利用するとします)   
　多くのJavaの資産を再利用することができるので、たいへん助かります。  
```sh
$ kotlinc foo.kt bar.kt -cp alice.jar:bob.jar -include-runtime foo.jar
```
　例えば、外部のjarファイルを利用したkotlinのjarを実行する際にはこのようなコマンドになります。  
```sh
$ kotlin -cp alice.jar:bob.jar:foo.jar FooKt
```
　このFooKtという名称はmain関数が含まれるfoo.ktファイルを指定するのに用いるようです。  
　

## JavaScriptをつかったサイトはphantomjs, selenium, jsoupの組みあせが楽
　JavaScriptによる非同期のデータ読み込みがある場合、単純に取得してjsoupなどで解析するだけだと、コンテンツが取れません。    
　JavaScriptを動作させて人間が見ていると同じような状態を作らないといけないので、selenium経由でphamtomjsを動作させてJavaScriptを動作させます。    
　たとえば、MicrosoftBingの画像検索は、Ajaxで描画されており、JavaScritpが動作しない環境では動作できません。(実験的な目的ですので、実際に画像をスクレイピングする際は、API経由で行ってください)  
```kotlin
    val driver = PhantomJSDriver()
    driver.manage().window().setSize(Dimension(4096,2160))
    driver.get("https://www.bing.com/images/search?q=${encoded}")
    //すべての画像が描画されるのを待つ
    Thread.sleep(3001)
    val html = driver.getPageSource() 
```
　htmlという変数に、JavaScriptが動作したあと描画された状態のhtmlが入ります。これをjsoupに入れることで、各種画像のsrcのURLがわかります。  
　発見した画像のURLを元に、wgetコマンドで任意のディレクトリ以下のフォルダに格納します。  
```kotlin
    val doc  = Jsoup.parse(html.toString(), "UTF-8")
    println(doc.title())
    doc.select("img").filter { x ->
       x.attr("class") == "mimg"
    }.map { x ->
       val data_bm = x.attr("data-bm")
       val src = x.attr("src")
       Runtime.getRuntime().exec("wget ${src} -O imgs/${name}/${data_bm}.png")             
    }
```
　PhantomJSは[このサイト](http://phantomjs.org/download.html)からコンパイル済みのバイナリをダウンロードして、PATHが通った場所においておく必要があります。

## Thread
　いくつか書き方があるようですが、もっとも簡単にできた実装です。  　
  スクレイピングするロジック全体を{}で囲った部分がthreadのインスタンスになって、そのthreadをstartさせたり,joinしたりして並列に動かすことができます。  　
```kotlin
    val threads = url_details.keys.map { url ->
      val th = Thread {
        if(url_details[url]!! == "まだ") { 
          _parser(url).map { next ->
            urls.add(next)
          } 
          println("終わりに更新 : $url")
          url_details[url] = "終わり"
          // save urls
          _save_conf( mapper.writeValueAsString(url_details) )
        }
      } 
      th
    }
```

## オブジェクトのシリアライズ、デシリアライズ
　jacksonというシリアライズモジュールが限定的に使えるようです。  
　Javaのライブラリだけではうまくいかないようで、Kotlin用のモジュールを別途読み込む必要があります。   
　限定的というのは、MutableMap<String, DataClass>をシリアライズ、デシリアライズしてみたところうまく行きませんでした。   
    MutableMap<String, String>はうまく行くので、ネスト構造がだめか、Data Classに対応してないかよくわかっていないです。  
　シリアライズの例  
```kotlin
val mapper = ObjectMapper().registerKotlinModule()
val serialzied = mapper.writeValueAsString(url_details) 
```
　デシリアライズの例  
```kotlin
val mapper = ObjectMapper().registerKotlinModule()
val url_details = mapper.readValue<MutableMap<String, String>>(json)
```

## 実際にスクレイピングしてみる
まずgit cloneする
```sh
$ git clone https://github.com/GINK03/kotlin-phantomjs-selenium-jsoup-parser.git
```
### 幅優先探索
　今のところ、二種類のスクレイピングまで実装が完了していて、単純にjaascritpを評価せずに、幅優先探索で、深さ100までスクレイピングをする。    
（自分のサイトのスクレイピングに使用していたため、特に制限は設けていませんが、50並列以上の並列アクセスで標準でアクセスするので、適宜調整してください。） 
```sh
$ sh run.scraper.sh widthSearch ${yourOwnSite}
```

### 画像探索
　Microsoft Bingを利用して、画像検索画面で検索します。実験的にAPIを使わないでAjaxで描画されるコンテンツを取れるかどうか、チャレンジしたコードですので、大量にアクセスして迷惑をかけてはいけないものだと思います。  
 検索リストは、github上のkancolle.txtのファイルを参考にしてください。  
```sh
sh run.scraper.sh image ${検索クエリリスト} ${出力ディレクトリ}
```

