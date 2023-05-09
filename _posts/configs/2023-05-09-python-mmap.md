---
layout: post
title: "python mmap"
date: 2023-05-09
excerpt: "pythonのmmapの使い方"
config: true
tag: ["python", "mmap"]
comments: false
sort_key: "2023-05-09"
update_dates: ["2023-05-09"]
---

# pythonのmmapの使い方

## 概要
 - 低レベルな`/dev/shm`でシェアードメモリーを扱うためのマネージャ
 - `joblib`や`multiprocessing.Manager`よりレイヤーが低いのでバイトレベルでの操作が必要になる

## 具体例

```python
import mmap
import os
import struct
import multiprocessing as mp

def update_memory(shared_memory, lock, index, value):
    with lock:
        shared_memory.seek(index * 8)  # 64ビット(8バイト)浮動小数点数を想定
        shared_memory.write(struct.pack("d", value))

if __name__ == "__main__":
    array_size = 5
    shared_memory_size = array_size * 8  # 64ビット(8バイト)浮動小数点数を想定

    # 共有メモリを作成します
    with open("/dev/shm/shared_memory", "wb") as f:
        f.truncate(shared_memory_size)

    # メモリマップファイルをオープンし、共有メモリにマップします
    with open("/dev/shm/shared_memory", "r+b") as f:
        shared_memory = mmap.mmap(f.fileno(), shared_memory_size)

    # ロックオブジェクトを作成します
    lock = mp.Lock()

    # プロセスを作成し、実行します
    processes = [mp.Process(target=update_memory, args=(shared_memory, lock, i, i * 2.0)) for i in range(array_size)]

    for p in processes:
        p.start()

    for p in processes:
        p.join()

    # 更新された共有メモリのデータを表示します
    for i in range(array_size):
        shared_memory.seek(i * 8)
        value = struct.unpack("d", shared_memory.read(8))[0]
        print(f"Value at index {i}: {value}")

    # 共有メモリを解放します
    shared_memory.close()
    os.unlink("/dev/shm/shared_memory")

"""
Value at index 0: 0.0
Value at index 1: 2.0
Value at index 2: 4.0
Value at index 3: 6.0
Value at index 4: 8.0
"""

## Google Colab
 - [shared-memory-example](https://colab.research.google.com/drive/1H_AIIg1pDEwvIj0tvT5UMCRjOYxiDxc6?usp=sharing)
```
