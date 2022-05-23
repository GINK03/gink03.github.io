---
layout: post
title: "javascript"
date: 2017-04-10
excerpt: "javascript関連"
project: true
learning: true
tag: ["javascript"]
comments: false
sort_key: "2022-04-01"
update_dates: ["2022-04-01","2022-02-27"]
---

# javascript関連

## 概要
 - 同じことをするのにたくさんのやり方がある

## 具体例

### 数値を特定小数点でroundする

```js
> parseFloat("1.23456").toFixed(2);
'1.23'
```

### arrayに要素が含まれているかどうか

```js
> const fruits = ["Banana", "Orange", "Apple", "Mango"];
undefined
> fruits.includes("Mango");
true
> fruits.includes("XXX");
false
```
 - 参考
   - [Array.prototype.includes()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes)

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

### arrayの要素をスワップ

```js
> let list = ["a", "b", "c"]
undefined
> list
[ 'a', 'b', 'c' ]
> [list[0], list[2]]
[ 'a', 'c' ]
> [list[0], list[2]] = [list[2], list[0]]
[ 'c', 'a' ]
> list
[ 'c', 'b', 'a' ]
```
 - 参考
   - [How to swap two array elements in JavaScript](https://flaviocopes.com/javascript-swap-array-elements/)
