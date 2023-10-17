---
layout: post
title: "python uuid"
date: 2023-10-17
excerpt: "pythonのuuidライブラリの概要と使い方"
config: true
tag: ["python", "uuid"]
comments: false
sort_key: "2023-10-17"
update_dates: ["2023-10-17"]
---

# pythonのuuidライブラリの概要と使い方

## 概要
 - uuidはpythonの標準ライブラリである

## uuidには4種類のuuidが存在する
 - uuid1
   - ホストIDと現在時刻を元に生成される
 - uuid3
   - 名前と名前空間を元にMD5で生成される
 - uuid4
   - ランダムな値を元に生成される
 - uuid5
   - 名前と名前空間を元にSHA-1で生成される

## 生成例

**uuid1**
```python
import uuid

print(uuid.uuid1()) # => 0f8fad5b-d9cb-469f-a165-70867728950e
```

**uuid3**
```python
import uuid

print(uuid.uuid3(uuid.NAMESPACE_DNS, 'python.org')) # => 6fa459ea-ee8a-3ca4-894e-db77e160355e
```

**uuid4**
```python
import uuid

print(uuid.uuid4()) # => 16fd2706-8baf-433b-82eb-8c7fada847da
```

**uuid5**
```python
import uuid

print(uuid.uuid5(uuid.NAMESPACE_DNS, 'python.org')) # => 886313e1-3b8a-5372-9b90-0c9aee199e5d
```

## 参考
 - [uuid — UUID objects according to RFC 4122](https://docs.python.org/3/library/uuid.html)
