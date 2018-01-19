---
layout: post
title:  "Practical Kotlin"
date:   2017-04-10
excerpt: "実戦Kotlin"
project: true
tag:
- MachineLearning
- Kotlin
comments: false
---

# Practical Kotlin

## はじめに
　便利で強力なKotlinであるが、いささかプラクティカルな例が欠けている  
　そのため、いくつか実戦で戦える例を示しながら、優秀な兵士を短期間でつくり上げるブートキャンプがこの講座だ!  

## 本書の構成
　この場合はこの書き方が有効だという事例を集めていく  
　参照しやすいように、このページに網羅的に、ブラウザから任意の機能が逆引きできるように記す  

#### コンパイル
```sh
kotlinc foo.kt -include-runtime -d foo.jar
```

#### 外部jar参照してコンパイル
```sh
kotlinc foo.kt -cp bar.jar -include-runtime foo.jar
```

#### Javaの資産を利用して実行
注意：この時だけ、jarファイルからメインクラスを指定せずに実行ではなくて、java likeコマンドにて実行
```
$ kotlin -cp .:jsoup-1.10.2.jar:scraper.jar  ScraperKt
```
scraper.jarのメインクラス名はScraperKtに暗黙的になる

#### 実行
```sh
java -jar foo.jar
```
#### ファイル保存
```kotlin
fun _save_conf(json:String) {
  PrintWriter("url_config.json").append(json).close()
} 
```

#### ファイル読み込み
```kotlin
fun _load_conf():MutableMap<String, String> { 
  try {
    val mapper = ObjectMapper().registerKotlinModule()
    val json   = File("url_details.json").readText()
    val url_details = mapper.readValue<MutableMap<String, String>>(json)
    return url_details
  } catch( e: java.io.FileNotFoundException ) {
    return mutableMapOf()
  }
}
```
#### CSVリードのプラクティス
一部、完全にsequenceとiteratorの棲み分けが完全にできていないのか、やたらめんどくさい（よくない)   
しばらくしたら、透過的な関数型のインターフェースができると思うので、それまでごまかしながら使う感じ  

iteratorでメモリを汚染せずにかけるかと思ったが全然できなかった  
```kotlin
import java.io.BufferedReader
import java.io.InputStream
import java.io.File
import java.util.stream.Collectors
import java.util.stream.*
fun main(args : Array<String>) { 
        val inputStream = File("mini.csv").inputStream()
        val lines = mutableListOf<String>() 
        inputStream.bufferedReader().useLines { xs -> xs.forEach { lines.add(it)} }
  val iter = lines.iterator()
  val keys = iter.next().split(",")
  println(keys)

  val df = mutableListOf<Map<String,Any>>()
  iter
    .forEach { line ->
      val vals = line.split(",")
      val obj = keys.zip(vals).toMap()
      println(obj)  
      df.add( obj )
  }
}
```
#### iterative(stream的な)ファイルの読み込み
```kotlin
fun chechHatena() {
  val br = BufferedReader(FileReader("./sampleRsv.csv"))
  var counter:Int = 0
  while(true) {
    counter += 1
    if( counter % 1000 == 0 ) {
      printerr("now iter ${counter}")
    }
    val line = br.readLine()
    if( line.split(" ")[0].contains("?") ) {
      println(line)
    }
  }
}
```

#### kotlin's yield
便利である
```kotlin
import kotlin.coroutines.experimental.*
fun infinit() = buildSequence {
  var i = 100L
  while(true) { 
    yield(i)
    i += 100
  }
}
fun main( args : Array<String> ) {
  println("a")
  for( i in infinit() ) { 
    println( i )
  }
}
```

#### Kotlinxでさらなるコルーチン
並列処理とかで期待できる
```kotlin
// Coroutine ARE light weigh
fun are_light_weight() = runBlocking<Unit>{
  println("called ARE light weight")
  val jobs = List(100_000) { // create a lot of coroutines and list their jobs
    launch(CommonPool) {                                                                                  
      delay(1000L)                                                                                    
      print(".")
    }                                                                                                
  }                                                                                                
  jobs.forEach { it.join() } // wait for all jobs to complete                                        
}  
```

#### gsonでシリアライズ
データクラスでもいけるぞいぞいぞい
```kotlin
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
...
val json = gson.toJson(m)
```

#### gson
gsonからの復旧  
リフレクションの型情報の設定がめんどくさい
```kotlin
val type = object : TypeToken<Map<String, String>>() {}.type
val map:Map<String,String> = gson.fromJson<Map<String, String>>(x, type)
```

#### genericな関数の作成
```kotlin
fun <T> printerr(t : T) {
  System.`err`.println(t)
}
```

#### last関数(tailだと思ってた)
```kotlin
last
fun <T> Iterable<T>.last(): T (source)
```

#### 特定の組みあせを全探索するアルゴリズム
```kotlin
/* 5000までの全組み合わせを計算する
BinaryStringで計算する */
fun main( args : Array<String> ) {
  (0..5000).map { x ->
    Integer.toBinaryString( x ).let { println(it) }
  }
}
```

#### urlパラメータからmap形式に変換
```kotlin
val raw  = urlDecoded!!.split("&").map { x ->
 x.split("=")
}.filter{ xs ->
 xs.size == 2
}.map { xs ->
  Pair(xs[0], xs[1])
}.toMap()
```

#### stdin, stream読み込み
```kotlin
import java.io.BufferedReader
import java.io.InputStreamReader

fun main(args: Array<String>) {
  println("新世界交響楽")
  BufferedReader(InputStreamReader(System.`in`)).lines().map { x ->
    println(x)
  }.forEach { }
}
```

#### メモリが足りない！！
環境変数$JAVA_OPTで定義されているらしく、未定義の場合はゴミみたいなパフォーマンスになるので、要編集

```sh
$ nvim $HOME/.sdkman/candidates/kotlin/current/bin/kotlinc
35 [ -n "$JAVA_OPTS" ] || JAVA_OPTS="-Xmx3000M -Xms3000M"  <- ここを編集
```

#### kuromojiによる形態素解析
色とりどりよりどりみどり
```kotlin
//import com.atilika.kuromoji.ipadic.Token
//import com.atilika.kuromoji.ipadic.Tokenizer
import com.atilika.kuromoji.ipadic.neologd.Tokenizer
import com.atilika.kuromoji.ipadic.neologd.Token
import com.atilika.kuromoji.ipadic.Tokenizer.Builder

fun main(args: Array<String> ) {
  println("Hello, Kuromoji.")
  val input = "一風堂のラーメンが食べたい"
  val tokenizer = Tokenizer()
  val tokens    = tokenizer.tokenize(input)
  tokens.map { x ->
    Pair(x.getSurface(), x.getAllFeatures())
  }.map { x ->
    val (term, feats) = x
    println(term)
  }
}
```

#### Kuromojiによるsteamによる形態素解析
Collectorsはいつも曖昧
```kotlin
import java.io.BufferedReader
import java.io.InputStreamReader
import com.atilika.kuromoji.ipadic.neologd.Tokenizer
import com.atilika.kuromoji.ipadic.neologd.Token
import com.atilika.kuromoji.ipadic.Tokenizer.Builder
import java.util.stream.Collectors
fun main(args: Array<String> ) {
  println("Hello, Kuromoji Streaming.")
  val tokenizer = Tokenizer()
  val sentences = BufferedReader(InputStreamReader(System.`in`)).lines().map { input ->
    val ret = tokenizer.tokenize(input).map { x ->
      Pair(x.getSurface(), x.getAllFeatures())
    }.map { x ->
      val (term, feats) = x
      term
    }.toList<String>()
    //sentences.add(ret)
    ret
  }.collect(Collectors.toList())
  //出力
  sentences.map { x ->
    println(x)
  }
}
```

#### 正規表現
```kotlin
    val doc = Jsoup.parse(File(name.toString()), "UTF-8")
    val title = doc.title().replace(" - Wikipedia","")
    doc.select("td").map { x ->
      //スリーサイズのみをマッチする
      if(Regex(""".*\d{1,}\s\-\s\d{1,}\s\-\s\d{1,}\scm.*""").matches(x.text()) ) {
        println("${title} ${x.text()}")
      }
    }
```

#### 関数拡張(head, tail実装編)
```kotlin
val <T> List<T>.tail: List<T>
  get() = drop(1)
val <T> List<T>.head: T
  get() = first()
```

#### coroutine + yield実装編
```kotlin
  val resultSeq = buildSequence {
    var result:ListObjectsV2Result? = null
    while (true) {
      result = s3Client.listObjectsV2(request)
      yield(result)
      result!!.isTruncated()
      request.setContinuationToken(result.getNextContinuationToken())
    }
  }
```

##### AWS S3バインディング編
```kotlin
  val bucketName = "***-ml-scraping"
  val s3Client:AmazonS3 = AmazonS3Client(ProfileCredentialsProvider())
  val request = ListObjectsV2Request().withBucketName(bucketName).withMaxKeys(200)
  val resultSeq = buildSequence {
    var result:ListObjectsV2Result? = null
    while (true) {
      result = s3Client.listObjectsV2(request)
      yield(result)
      result!!.isTruncated()
      request.setContinuationToken(result.getNextContinuationToken())
    }
  }
  resultSeq.forEachIndexed { ind, result ->
    if( ind%1 == 0) println("now iter ${ind}")
    result!!.getObjectSummaries().mapIndexed { i,x ->
      val key               = x.getKey()
      if( key.contains("headline") ) {
        val s3object:S3Object = s3Client.getObject(GetObjectRequest(bucketName, key))
        val value  = BufferedReader(InputStreamReader(s3object.getObjectContent())).lines().map { x ->
                         x
                       }.collect(Collectors.toList())
                       .joinToString("")
                       .replace("\n", " ")
        val date_time = key.split("_").slice(0..3).joinToString("_")
        val hash_url  = key.split("=").last()
        //println("${date_time} ${hash_url} ${key} ${value}")
        val filename  = "${date_time}_${hash_url}"
        PrintWriter("out/${filename}.txt").append(value).close()
      }
    }
  }
```

#### シリアライズしたオブジェクトから復旧
```kotlin
fun _load_conf():MutableMap<String, String> { 
  try {
    val mapper = ObjectMapper().registerKotlinModule()
    val json   = File("url_config.json").readText()
    val urls_config = mapper.readValue<MutableMap<String, String>>(json)
    return urls_config
  } catch( e: java.io.FileNotFoundException ) {
    return mutableMapOf()
  }
}
```

#### javaにおけるglob
```kotlin
import java.io.*
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
fun main(args: Array<String>) {
  Files.newDirectoryStream(Paths.get("./out"), "*").map { name ->
    println(name)
  }
}
```

#### jsoupによるhtml取得と解析
```kotlin
fun _parser(url:String):Set<String> { 
  var doc:Document
  try { 
    doc = Jsoup.connect(url).get()
  } catch( e : org.jsoup.HttpStatusException ) {
    println(e)
    return setOf()
  } catch( e : java.lang.IllegalArgumentException ) { 
    println(e)
    return setOf()
  } catch( e : java.net.MalformedURLException ) {
    println(e)
    return setOf()
  }
  if( doc == null || doc.body() == null ) 
    return setOf()
  val btext =  doc.body().text()     
  val title =  doc.title()    
  val urls = doc.select("a[href]").map { link ->
    link.attr("abs:href")
  }
  _writer(url, title, btext)
  return  urls.toSet()
}
```

#### ファイルシステムを利用した似非KVS
```kotlin
fun _writer(url:String, title:String, text:String) {
   val escapeTitle = title.replace("/", "___SLA___")
   val escapeUrl   = url.replace("http://", "")
                        .replace("https://", "")
                        .replace("/", "_")
   var joined = "${escapeUrl}_${escapeTitle}"
   if(joined.length > 50 ) {
     joined = joined.slice(0..50)
   }
   val f = PrintWriter("out/${joined}")
   f.append(text)
   f.close()
}
```

#### N進数変換
```kotlin
//stdioからの入力を7進数に変換する例である  
fun main(args: Array<String>) {
  var N = readLine()!!.toInt()
  val es:MutableList<Int> = mutableListOf()
  if( N == 0 ) es.add(0)
  while( N != 0 ) {
    val k = N%7
    es.add(k)
    N /= 7
  }
  println(es.asReversed().joinToString(""))
}
```

#### sortedBy(sortedBy系)
```kotlin
fun main(args: Array<String> ) { 
  val L = readLine()!!.toInt()
  val N = readLine()!!.toInt()
  var acc = 0 
  val ws = readLine()!!.split(" ").map { x ->
    x.toInt()
  }.sortedBy { x ->  
    x   
  }.filter { x ->
    acc += x
    if(acc <= L ) { 
      true 
    } else {
      false
    }   
  }
  println(ws.size)
}
```

#### 素数(素数を用いた特殊な場合分け)
```kotlin
fun main(args: Array<String>) { 
  val n = readLine()!!.toInt()
  val prime_check = (0..10001).map { x -> 1 }.toMutableList()
  val prime_list:MutableList<Int> = mutableListOf()
  val dp:MutableSet<Int> = mutableSetOf(0, 1)
  (2..n+1).map { x -> 
    if(prime_check[x] == 1) { 
      prime_list.add(x)
      (x*2..10001 step x).map { x2 ->
        prime_check[x2] = 0
      }
    }
    for(x2 in prime_list) { 
      if( !dp.contains(x - x2) ) {
        dp.add(x)
        break
      }
    }
  }
  if( dp.contains(n) ) { 
    println("Win")
  } else {
    println("Lose")
  }
}
```

#### Unboundのやり方
```kotlin
fun main(args: Array<String>) { 
  (1..readLine()!!.toInt() ).map { 
    readLine()!!.split(" ").map { x -> x.toInt() }
  }.map { x -> 
    val (n, k) = x
    if( (n-1)%(k+1) == 0 )
      println("Lose")
    else
      println("Win")
  }
}
```

#### BigDecimal, Power, Rem, Mul, Add
```kotlin
import java.math.BigDecimal
fun main(args: Array<String>) { 
  val base = BigDecimal(readLine()!!.split(" ")[0])
  val ans  = readLine()!!.split(" ").map { x -> 
    x.toInt()
  }.map { x ->
    base.pow(x).rem(BigDecimal("1000003")) 
  }.reduce { e, x ->
    e.add(x)
  }
  println(ans)
}
```

#### min, max
```kotlin
fun main(args: Array<String>) {
  val n = readLine()!!.toInt()
  readLine()
  val eval = (1..n).map { 
    readLine()!!.toInt()
  }.toList()
  println(eval.max()!! - eval.min()!!)
}
```

#### math.ceil
```kotlin
fun main(args:Array<String>) {
  val (a, b) = readLine()!!.split(" ").map{ x -> x.toDouble() }
  println(Math.ceil(b/a).toInt() )
}
```

#### state machine
```kotlin
fun main(args: Array<String>) {
  val (N, K) = readLine()!!.split(" ").map{ x -> x.toInt() }
  val se     = readLine()!!
  val start  = se[K-1]
  if(start == '(') {
    var c = 0
    for(i in (K..N) ) {
      if(se[i] == '(') c++
      else{
        if(c==0) {
          println(i+1)
          break
        }else{
          c--
        }
      }
    }
  } else if( start == ')') {
    var c = 0
    for(i in (K-2 downTo 0) ) {
      if(se[i] == ')') {
        c++
      }
      else{
        if(c==0) {
          println(i+1)
          break
        }else{
          c--
        }
      }
    }
  }
}
```
