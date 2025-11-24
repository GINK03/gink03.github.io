---
layout: post
title: "python asyncio"
date: 2025-11-24
excerpt: "asyncioの基本とTaskGroupやSemaphoreまで"
tag: ["python", "asyncio"]
config: true
comments: false
sort_key: "2025-11-24"
update_dates: ["2025-11-24"]
---

# pythonでasyncioを使うときの全体像

## 概要
 - asyncioはasyncとawaitでI/Oバウンド処理を並行に動かすための仕組み
 - python311以降はTaskGroupによる構造化並行処理が推奨されている
 - TaskGroupはタスクの場を提供するコンテキストマネージャで中身の処理はasync defで定義したコルーチンが担当する
 - ブロッキング処理はasyncio.to_threadで逃がしイベントループを詰まらせないようにする
 - 並列数の制限はTaskGroupではなくSemaphoreやヘルパ関数で行う

pythonのasyncioは「async defとawaitでI/Oバウンド処理を並行に動かす仕組み」  
I/O待ちが長い処理をまとめてさばくための道具

 - Web APIを大量に叩く
 - ファイルやデータベースへの読み書き
 - 外部サービスへの問い合わせをまとめて処理したい


## 最低限覚えておきたい3ステップ

### 1 async defでコルーチンを定義する

```python
import asyncio

async def say_after(delay, msg):
    await asyncio.sleep(delay)  # ここで他のタスクに処理が切り替わる
    print(msg)
```

 - async defで定義した関数をコルーチン関数と呼ぶ
 - 時間のかかるI/Oなどでawaitするとその待ち時間のあいだ他のコルーチンが動ける


### 2 イベントループで実行する

```python
import asyncio

async def main():
    await say_after(1, "hello")
    await say_after(2, "world")

asyncio.run(main())
```

 - エントリポイントもasync def mainで書き最後にasyncio.run(main())とする形が基本
 - 自前のイベントループ生成よりasyncio.runに任せる運用


### 3 並行に動かす

順番に待つ場合

```python
async def main():
    await say_after(1, "A")
    await say_after(1, "B")  # Aが終わってからB
```

並行に動かす場合

```python
async def main():
    task1 = asyncio.create_task(say_after(1, "A"))
    task2 = asyncio.create_task(say_after(1, "B"))
    await task1
    await task2
```

 - asyncio.create_taskでイベントループに登録すると両方の処理が同時に走り出す
 - 複数まとめて待つならawait asyncio.gather(task1, task2)もよく使う


## 最小サンプル

```python
import asyncio

async def worker(n):
    print(f"task {n} start")
    await asyncio.sleep(1)
    print(f"task {n} end")

async def main():
    await asyncio.gather(
        worker(1),
        worker(2),
        worker(3),
    )

asyncio.run(main())
```

## TaskGroupでタスクを束ねる

```python
import asyncio

async def task1():
    await asyncio.sleep(1)
    print("task1 done")

async def task2():
    await asyncio.sleep(2)
    print("task2 done")

async def main():
    async with asyncio.TaskGroup() as tg:
        tg.create_task(task1())
        tg.create_task(task2())
    print("all done")

asyncio.run(main())
```

 - タスクを束ねるコンテキストマネージャ
 - async withブロック終了時に全タスク完了または例外終了
 - 一つが例外なら残りを自動キャンセルし迷子タスク防止


## ブロッキング処理はto_threadで逃がす

```python
import asyncio
import time

def heavy_processing():
    time.sleep(1)  # 本当は重い処理がある想定
    return "done"

async def main():
    result = await asyncio.to_thread(heavy_processing)
    print(result)

asyncio.run(main())
```


# 並列数を制限したいときの書き方

## Semaphoreで同時実行数を制限する

```python
import asyncio

limit = asyncio.Semaphore(3)  # 同時実行3個に制限

async def worker_with_limit(task_id, semaphore):
    async with semaphore:
        print(f"start {task_id}")
        await asyncio.sleep(2)
        print(f"finish {task_id}")

async def main():
    tasks = [worker_with_limit(i, limit) for i in range(10)]
    await asyncio.gather(*tasks)

asyncio.run(main())
```

 - 最初の3つだけが同時に動き残りは空きが出るまで待機する
 - async with semaphoreブロックを抜けると鍵が返却され次のタスクが動き出す


## TaskGroupとSemaphoreを組み合わせる

 - TaskGroup自体には並列数を制限するオプションはない
 - ライフサイクル管理はTaskGroup並列数制限はSemaphoreという役割分担

```python
import asyncio

async def worker_with_limit(task_id, semaphore):
    async with semaphore:
        print(f"start {task_id}")
        await asyncio.sleep(1)
        print(f"finish {task_id}")

async def main():
    limit = asyncio.Semaphore(3)
    async with asyncio.TaskGroup() as tg:
        for i in range(10):
            tg.create_task(worker_with_limit(i, limit))

asyncio.run(main())
```
