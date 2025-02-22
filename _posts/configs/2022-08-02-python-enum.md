---
layout: post
title: "python enum"
date: 2022-08-02
excerpt: "python enumの使い方"
tags: ["python", "enum"]
config: true
comments: false
sort_key: "2022-08-02"
update_dates: ["2022-08-02"]
---

# python enumの使い方

## 概要
 - pythonで扱えるenum型
 - `str`や`int`を継承することができる
 - `IntEnum`を継承すると数値として扱える
 - `Flag`を継承するとbitを立てるようなflag表現にする
 - `auto()`で初期化すると数値等を設定する必要はない

## 具体例

```python
from enum import Enum, IntEnum, auto, Flag

class C0(Enum):
    RED = 0
    BLUE = 1
    GREEN = 2

assert C0.RED != 0
```

**IntEnumを継承する例**

```python
class C1(IntEnum):
    RED = 0
    BLUE = 1
    GREEN = 2

assert C1.RED == 0

C3 = Enum("C3", ["RED", "BLUE", "GREEN"])
assert C3.RED != C3.BLUE
```

**auto()を使う例**

```python
class C4(Enum):
    RED = auto()
    BLUE = auto()
    GREEN = auto()

class C5(Flag):
    RED = auto()
    GREEN = auto()
    BLUE = auto()
    MAGENTA = RED | BLUE
    YELLOW = RED | GREEN
    CYAN = GREEN | BLUE

print(C5(3)) # C5.YELLOW
print(C5(7)) # C5.CYAN|MAGENTA|BLUE|YELLOW|GREEN|RED
```

**str型を継承する例**

```python
from enum import Enum

class StageEnum(str, Enum):
    AWARENESS = "認知段階"
    INTEREST = "興味関心"
    COMPARISON = "比較検討"
    PURCHASE = "購入段階"

print(StageEnum.AWARENESS) # StageEnum.AWARENESS
print(StageEnum.AWARENESS.value) # 認知段階
```

## 参考
 - [enum — Support for enumerations/docs.python.org](https://docs.python.org/3/library/enum.html)
