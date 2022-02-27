---
layout: post
title: "javascript"
date: 2017-04-10
excerpt: "javascript関連"
project: true
learning: true
tag: ["javascript"]
comments: false
---

# javascript関連

## 概要
 - 同じことをするのにたくさんのやり方がある

## 具体的なオペレーション

### arrayのpopとshift

**shift**  
```js
> const fruits = ["Banana", "Orange", "Apple", "Mango"];
undefined
> fruits.shift();
'Banana'
> fruits
[ 'Orange', 'Apple', 'Mango' ]
```

**pop**  
```js
> const fruits = ["Banana", "Orange", "Apple", "Mango"];
undefined
> fruits.pop()
'Mango'
> fruits
[ 'Banana', 'Orange', 'Apple' ]
```

### 固定サイズのarrayを作成する

**一次元のarray**  
```js
>  let array = Array(3).fill()
undefined
> array
[ undefined, undefined, undefined ]
```

**二次元のarray**  
```js
> let array = Array(5).fill().map(() => Array(3));
undefined
> array
[
  [ <3 empty items> ],
  [ <3 empty items> ],
  [ <3 empty items> ],
  [ <3 empty items> ],
  [ <3 empty items> ]
]
```
