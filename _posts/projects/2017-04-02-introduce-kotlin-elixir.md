---
layout: post
title:  "データ分析に使える言語はPython, Rだけではない"
date:   2017-04-02
excerpt: "Machine Learning 機械学習チーム向け資料."
project: true
tag:
- MachineLearning
- Python
- R
- Kotlin
- Scala
comments: false
---
# データ分析に使える言語はPython, Rだけではない
## 目次
- データ(直列)操作  
- generatorと遅延評価の闇  
- 100個の任意のデータを得るためのパフォーマンス比較  
## データ(直列)操作とは
　SQL系のデータ集計と系譜を別にする分析手法がある。それは、データの流れを関数のmap, filter, reduce(fold)関数を連続的に通すことで任意の結果を求めるスタイルである。  
　もともと、マルチプロセス処理やコンピュータをまたいでの並列処理との相性がよく、よく使われる。  
　具体例を示すとPythonではこのようになる。Pythonでは可読性と構文的な複雑さを回避するため、lambdaと呼ばれる匿名関数は非常に限定的である。  
[Python ideone](http://ideone.com/2RB6HG)
```python
"""
カンマ区切りで入力し、奇数のみを取り出し二乗する
"""
import sys
line =  input()
line = line.strip()
ents = line.split(",")
print(list(map(lambda x:x**2, filter(lambda x:x%2==1, map(int, ents)))))
```
　この記法をみて、この書き方を積極的に使いたいと思うだろうか。非常に可読性がわるいことがわかるだろう。  
　Kotlinで書き直すとこのようになる。  
[Kotlin ideone](http://ideone.com/9MELWe)
```kotlin
fun main(args:Array<String>){
  val ans = readLine()!!.split(",").map { x -> 
    x.toInt()
  }.filter { x ->
    x%2 == 1
  }.map { x ->
    x*x
  }.toList()
  println(ans)
}
```
Elixirで書き直すとこのようになる
```kotlin
defmodule Exlixr do
  def main do
    input = IO.gets ""
    stream = String.split(String.strip(input), ",")
       |> Stream.map( fn(x) -> String.to_integer(x) end )
       |> Stream.filter( fn(x) -> rem(x, 2) == 1 end)
       |> Stream.map( fn(x) -> x*x end )
       |> Enum.to_list
      IO.inspect stream
     end
   end
Exlixr.main
```
　縦にかけるようになり、だいぶ透明性が上がったような、つまり人間にとって読みやすい状態になっていないだろうか。  
 主観もあるだろうが、このようにobjectのインスタンスのあとに、メソッドを繋げられデータを匿名関数に射影し続けられるので、可読性を維持しやすい。

## generatorと遅延評価の闇
　generatorとはご存知の方も多いのではないだろうか。  
　これはどういうことかというと、C#系統やPythonではyieldをつかったiterativeな関数呼び出しなどが該当する。  
　メリットとしては、実際に値を取り出す操作をする直前に内部の評価機能が働き、初めて計算コストが発生する。hadoopやsparkなどで分析する際には実際には評価しないデータの中から、効率的にデータを取り出すのに一役も二役も買っている。  
　Python2とPython3の違い、Python3のみデフォルトで関数射影がgeneratorになっているのだがその例を示す。  
[Python2 ideone](http://ideone.com/feIVwf)  
Python2
```python
# coding: utf-8
map(lambda x:x**2, filter(lambda x:x%2==1, xrange(1,100000000)))
#Success	time: 0.64 memory: 1291264 signal:0
```
これをPython3で実行すると、遅延評価となるから、実効速度に差が出る。  
Python3
```python
map(lambda x:x**2, filter(lambda x:x%2==1, range(1,100000000)))
#Success	#stdin #stdout 0.02s 27720KB
```
秒数においてかなりの差が発生していることがわかるだろう。    
記法が変わらないように見えて大幅に内容は変わっているし、そのことを理解してデータ分析に当たるのは、データサイズに応じてプログラミングできようになるので、価値があることである。    

## 100個の任意のデータを得るためのパフォーマンス比較
　1000万個のランダムな数値のなかから奇数のみを取り出し、二乗して、その合計を計算するというプログラムを書く。  
　この時、もっとも早い処理系はどれなのだろうか。  
Python3
```python
$ time cat dataset.txt | python3 hikaku.py                                    
150123209
real    0m3.225s
```
Kotln
```kotlin
$ time cat dataset.txt | java -jar -Xmx6g hikaku.jar                          
150123209
real    0m2.078s
```
Elixir
```elixir 
$ time cat dataset.txt | elixir hikaku.exs 
150123209
real    2m4.228s
```
ちょっと、Elixirさん...

# もうひとつの実装系のJavaの必要性
- Sparkで実装されているScalaについて
- Scalaは発火しやすい印象
- ScalaとKotlinの差

## Sparkで実装されているScalaについて
　Apache Sparkはモダンな設計思想とフレームワークということもあり、PythonとScalaを標準でサポートしている。ScalaはPythonでコーディングが困難なデータの直列操作にも対応している。  
　SparkのRDDは、Spark内部の分散処理を意識しないで、データ直列操作をする感覚で操作できる。  
　KotlinとScalaの差はなんなのかというと、いろいろあるが、使ってみて使いやすいほうを使えばいいと思う。  
 
## Scalaは発火しやすい印象
　エモい話なのなのだが、もともとTwitter社がRuby on Railsの代わりにScalaのフレームワークを作って流行ったという背景が多少なりともある。twitterでScalaからnode jsに移行したといことで大騒ぎになった。真偽はよくわかってないが、Scalaには熱心に解説してくださる方がいて、その方はたいていTwitterユーザですので、衝撃は大きかったようだ。
[参考](http://www.utali.io/entry/2017/02/24/170000)
　反論も多数見かけるし、攻撃的な論調もおおく、少々危険な気がしている。  
[参考](http://kmizu.hatenablog.com/entry/2017/03/22/233335)

## ScalaとKotlinの差
　今回はKotlin中心に紹介したが、Scalaはそれはそれで素晴らしい言語です。いくつかシンタックス以外にも機能の面で違いがあるので、例示したいと思います。
　他にもいろいろありますが、私がよく使う機能での差異が大きい物を示しています

**Scalaのみある機能**
- Existential types [参考](http://www.drmaciver.com/2008/03/existential-types-in-scala/)
- Complicated logic for initialization of traits
- Custom symbolic operations

**Kotlinのみある機能**  
- Zero-overhead null-safety
- Smart casts
- Kotlin's Inline functions facilitate Nonlocal jumps
- First-class delegation

# 具体的な例
## (TreasureDataなどの)ウェブページの閲覧データのCSVダンプデータから、ipアドレスをparseして、出現頻度をカウントする
TresureDataに限らず、生ログは非常に構造化が難しく、よくわからない例外が入っていたりする。  
Kotlinのパーサが見当たらなかったため、自力で実装した（吐血）  
Kotlin  
```kotlin
import java.util.*
fun csv_parse(head:List<String>, text:String):Map<String, String> {
  var result:MutableList<String> = mutableListOf<String>()
  var mini_buff = mutableListOf<String>()
  for(x in text.split(",")) { 
    if( x.length > 0 && x[0] == '"' ) { 
      if(x[x.lastIndex] == '"') { 
        result.add( x ) 
      }   
      if(x[x.lastIndex] != '"') { 
        mini_buff.add(x)
      }   
      continue
    }   
    if(mini_buff.size > 0 && x.length > 0 && x[x.lastIndex] == '"') {
      mini_buff.add(x)
      val mini_build = mini_buff.joinToString(",")
      result.add( mini_build.slice(1..mini_build.lastIndex-1) )
      mini_buff = mutableListOf<String>()
      continue
    }   
    if(mini_buff.size > 0 && x.length > 0 && x[0] != '"' && x[x.lastIndex] != '"') {
      mini_buff.add(x)
      continue
    }   
    result.add(x)
  }   
  val zipped = head.zip(result).toMap()
  return zipped
}
fun main(args: Array<String>) {
  val head = readLine()!!.split(",")
  val mmap = mutableMapOf<String, Int>()
  val max  = args.toList()[0].toInt()
  (0..max).map { x ->
    val text   = readLine()!!
    val params = csv_parse(head, text)
    if(params["ip"] != null) {
      if(mmap.get(params["ip"]) == null) {
        mmap.put(params["ip"]!!, 0)  
      }   
      mmap[params["ip"]!!] = mmap[params["ip"]!!]!! + 1 
    }   
  }
  val list: List<Pair<String, Int>> = mmap.toList()
  list.sortedBy { it ->  
    it.second*-1
  }.map { x ->  
    println(x)
  }
}
```
## 一文字欠損した場所を求める: [yukicoder no.494](http://yukicoder.me/problems/no/494)
Python
```python
ans = list(filter(lambda x:x[0]!=x[1], zip('yukicoder', input())))
print(ans[0][0])
```
Kotlin
```kotlin
fun main(args: Array<String>){
  val ans = readLine()?.zip("yukicoder")!!.filter { x -> 
   val (a, b)  = x
   a != b
  }.toList()[0].toList()[1]
  println(ans) 
}
```

## 正規表現によるmatch: [yukicoder no.495](https://yukicoder.me/problems/no/495)
Python
```python
import re
text = input()
print(len(re.findall(r'\(\^\^\*\)', text)), end=" ")
print(len(re.findall(r'\(\*\^\^\)', text)))
```
Kotlin
```kotlin
fun main(args:Array<String>) { 
  val text:String = readLine()!!
  val a = Regex("""\(\^\^\*\)""").findAll(text).map{ x -> x.value }.toList().size
  val b = Regex("""\(\*\^\^\)""").findAll(text).map{ x -> x.value }.toList().size
  println("$a $b")
}
```

## sortの実装: [yukicoder no.490](http://yukicoder.me/submissions/163076)
Python
```python
n = int(input())
targets = list(map(int, input().split()))
for i in range(1, 2*n-3 ):
  for p in range(i):
    q = i - p
    if n <= q: continue
    if p >= q: break
    if targets[p] > targets[q]:
      targets[p], targets[q] = targets[q], targets[p]
print(' '.join(list(map(str,targets))))
```
Kotlin
```kotlin
fun main(args: Array<String> ) {
  val n  = readLine()!!.toInt()
  val ts:MutableList<Int> = readLine()!!.split(" ").map { x -> x.toInt() }.toMutableList()
  for(i in (1..2*n - 3 - 1)) { 
    for(p in (0..i) ) {
      val q = i - p 
      if( n <= q ) { continue } 
      if( p >= q ) { break }
      if(ts[p] > ts[q]) {
          val swap = ts[p]
          ts[p] = ts[q]
          ts[q] = swap
      }
    }
  } 
  println(ts.joinToString(" ") )
}
```
# 参考
[1] https://speakerdeck.com/antoniolg/scala-vs-kotlin
