---
layout: post
title: "Simplest Python RPC"
date: 2020-02-06
excerpt: ""
tags: [python, rpc]
comments: false
---

# Simplest Python RPC

## 目次
 - 今のPythonのRPCは種類が多すぎる
 - 標準ライブラリで実行できる価値
 - コードの説明
 - 実際に動かしてみて


## 今のPythonのRPCは種類が多すぎる
 2020年現在、数多くのRPCがOSSとして公開されていますが、種類が多すぎる点と、それに伴う選択コストの増加と、評価コストの増加、学習コストの増加が個人的な課題であると感じています。  

 社会人をやっているととにかく時間が貴重なので、次々現れるライブラリを検討していたり、使い方を学んだりしているのは、PoCを素早く行う場合やAPIなど閉じた小さいプロダクトを作る際には適切ではありません。  

 Pythonでは `multiprocessing` の中に `manager` クラスが存在して、multiprocessing時のプロセス間通信をネットワーク越しに動作させることで、高性能なRemote Procudure Callを実装することができます。  

 Remote Procudure Call(以下, RPC)とは、ネットワーク上の別のコンピュータで、何らかの処理を呼び出したり、処理させたりすることで、大規模な分散処理を行う際に便利です。 

## 標準ライブラリで実行できる価値
 数多くのライブラリを使ってきたのですが、そのライブラリのメンテナがいなくなったりpull requestを受け入れられる体制を持っていなかったり、時間がなかったりなどで多くの、"良さそう"と思われるライブラリが過去の時代に取り残されていきました。  

 できれば、ライブラリ依存せず、かつ簡単に実装できれば、それはPythonが存在する限り(もしくはPythonの中でdeprecatedにならない限り)使用できることになります。  

## コードの説明
 `server` と `client` に分けて考えることができる要素で、`server` は命令を待ち受け、 `client` は命令を発行します。  

**server**  

```python
from multiprocessing.managers import BaseManager as Manager
import os

# インメモリのKVSを想定
obj = {}
def get(k):
    print('get', k)
    return obj.get(k)

def put(k, v):
    obj[k] = v
    print('put', k,v)

# serverのunameを取得(LinuxとかMacOSとかわかる関数)
def get_uname():
    print('get_uname')
    return str(os.uname())

if __name__ == "__main__":
    port_num = 4343
    Manager.register("get", get) # 待受に使う関数を登録
    Manager.register("put", put)
    Manager.register("get_uname", get_uname)
    manager = Manager(("", port_num), authkey=b"password") # ホスト名を空白にすることで任意の箇所から命令を受け入れられる。パスワードが設定できる
    manager.start()
    input("Press any key to kill server".center(50, "-")) # なにか入力したら終了
    manager.shutdown()
```

**client** 

```python
from multiprocessing.managers import BaseManager as Manager
Manager.register("get") # 関数を登録
Manager.register("put")
Manager.register("get_uname")

if __name__ == "__main__":
    port_num = 4343

    manager = Manager(address=('25.48.219.74', port_num), authkey=b"password")
    manager.connect()
    print('get', manager.get('a')) # Noneが帰ってくるはず
    print('put', manager.put('a', 10)) # a -> 10をセット
    print('get', manager.get('a').conjugate()) # 10が帰ってくるはず, (primitive型などは、conjugate関数で値を取り出す)
    print('get_uname', manager.get_uname()) # MacOSでクライアントを実行しているが、ServerのLinuxが帰ってくるはず
```

## 実際に動かしてみて

serverをLinux(Ubuntu), clientをMacOS(darwin)から、コンビニカフェからお家のPCに上記のプログラムを実行してみまました。  

結果は想定通りで、任意の動作をさせることができました。  

<div align="center">
  <img width="100%" src="https://user-images.githubusercontent.com/4949982/74081611-3dc29900-4a94-11ea-83f8-1968d013a1da.png">
</div>

これで例えば、YouTubeの視聴数や、Twitterのトレンドキーワードなどは処理できそうですし、いちいち高頻度でBigQueryやRedShiftなどを稼働させなくても効率的にデータをアグリゲートできます。  

新しいすごいツールを学習することも重要ですが、既存のもので小さく収めることも重要で、全体的なやりたいことに対する達成コストが非常に安く済むので、ぜひこの方法も検討していただけると幸いです。  

## おまけ：YouTubeの視聴数カウントコード
  clientをフォークして複数から大量のアクセスが有ったという想定で、やってみました。  

**cleint**  
```python
from concurrent.futures import ProcessPoolExecutor
import random
from multiprocessing.managers import BaseManager as Manager
Manager.register("get")  # 関数を登録
Manager.register("inc")

def extract(x):
    if hasattr(x, 'conjugate'):
        return x.conjugate()
    else:
        return x


def hikakin_watch(num):
    port_num = 4343
    manager = Manager(address=('127.0.0.1', port_num), authkey=b"password")
    manager.connect()
    for i in range(1000):
        try:
            now = extract(manager.get('hikakin'))
            print(now)
            manager.inc('hikakin')
        except Exception as exc:
            print(exc)

if __name__ == "__main__":
    with ProcessPoolExecutor(max_workers=5) as exe:
        exe.map(hikakin_watch, list(range(5)))
    
    port_num = 4343
    manager = Manager(address=('127.0.0.1', port_num), authkey=b"password")
    manager.connect()
    now = extract(manager.get('hikakin'))
    print(now)
```

**server**  

```python
from multiprocessing.managers import BaseManager as Manager
import os

# インメモリのKVSを想定
obj = {}
def get(k):
    if k not in obj:
        obj[k] = 0
    return obj.get(k)

def inc(k):
    obj[k] += 1

if __name__ == "__main__":
    port_num = 4343
    Manager.register("get", get) # 待受に使う関数を登録
    Manager.register("inc", inc)
    manager = Manager(("", port_num), authkey=b"password") # ホスト名を空白にすることで任意の箇所から命令を受け入れられる。パスワードが設定できる
    manager.start()
    input("Press any key to kill server".center(50, "-")) # なにか入力したら終了
    manager.shutdown()
```

期待する出力として5000が得られ、並列アクセスに対しても、きちんと排他制御ができることがわかりました。  

YouTubeの視聴数のカウントなどに使えそうです。  

