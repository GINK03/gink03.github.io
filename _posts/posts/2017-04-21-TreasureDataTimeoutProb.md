---
layout: post
title: "treasuredata timeout problem"
date: 2017-04-21
excerpt: ""
tags: [潜在不具合]
comments: false
---

# Java APIのいろんなアレ
　msgpackはバイナリレベルで型情報を保持しているが、Javaが一部リフレクションを使わないと行けなかったり、  
 Java7でないとコンパイルできなかったり、Class Duplication Errorになるなど。
 

## centos7をdockerとかで立ち上げ
```sh
$ sudo docker run -it centos
```

## centos7にopenjdk7とかもろもろ入れる
```
# yum install java-1.7.0-openjdk-devel
# yum install net-tools
# yum install maven
```

## git repositoryからダンロード
```sh
# git clone https://github.com/treasure-data/td-client-java.git
```

## コンパイル
```sh
# mvn package -Dmaven.test.skip=true
```

## Jarを転送
```sh
# scp -r alice bob@charlie:/dave/ellen
```

## タイムアウト問題
　timeout処理系に問題があり、全取得してしまう前に、例外を吐いて死んでしまうので、timeoutを長くする  
TDHttpClient.javaというファイルにおいて、
```sh
358             //final int retryLimit = config.retryLimit;
359             final int retryLimit = Integer.MAX_VALUE;
```
このように変更したところ、バグが発生しなくなった。

## driverのIFのgoogle funciton問題
　処理する内容をGoogle Funcitonの関数オブジェクトに封じ込めて、処理することを想定しているのだが、Java Unique過ぎて
 使い物にならない。そこで、副作用を発現させて、強制的にハンドラを取り出す。  
 ```java
   public List<ArrayValue> bufferingHandler(TDClient client, String jobId) {
    System.out.println("buffering handlderです。");
    List<ArrayValue> res = new ArrayList<ArrayValue>();
    client.jobResult(jobId, TDResultFormat.MESSAGE_PACK_GZ, new Function<InputStream, Object>() {
      @Override
      public Object apply(InputStream input) {
        try {
          MessageUnpacker unpacker = MessagePack.newDefaultUnpacker(new GZIPInputStream(input));
          while(unpacker.hasNext()) {
            // Each row of the query result is array type value (e.g., [1, "name", ...])
            ArrayValue array = unpacker.unpackValue().asArrayValue();
            res.add(array);
          }
        } catch (Exception e) {
          System.out.println("内部エラーが発生しました");
          System.out.println(e);
        }
        return 0;
      }
    });
    return res;
  }
 ```

 信じられないことにこれは動いてしまう。Javaの言語仕様が持つエラッタのように思える。  
