---
layout: post
title: "rustのprintln"
date: "2022-07-06"
excerpt: "rustのprintlnの使い方"
config: true
tag: ["rust", "println", "macro"]
comments: false
sort_key: "2022-07-06"
update_dates: ["2022-07-06"]
---

# rustのprintlnの使い方

## 概要
 - 一種のマクロ
 - pythonのf-stringのような使い方

## printの種類
 - `print!()`
   - 改行しない
 - `println!()`
   - 改行する

## align
 - `: <`
   - 左寄せ
 - `: >`
   - 右寄せ
 - `: ^`
   - 中央
 - `: n`
   - 最大n文字の空白でパティング
 - `: 0n`
   - 最大n文字の0でパティング

## 基数
 - `:b`
   - 2進数
 - `:o`
   - 8進数
 - `:x`
   - 16進数
 - `:e`
   - 指数

## 具体例

```rust
println!("Hello {}!", "world"); // Hello world.

println!("{0: <8} | {1: >8} | {2: ^8} | {3: <08} | {4: >08} | {hundred: >08}",
         "Left",
         "Right",
         "Center",
         42,
         999,
         hundred=100);
// => Left     |    Right |  Center  | 42000000 | 00000999 | 00000100

println!("{:b}", 1234);  // => 10011010010
println!("{:o}", 1234);  // => 2322
println!("{:x}", 1234);  // => 4d2
println!("{:X}", 1234);  // => 4D2
println!("{:e}", 12.34); // => 1.234e1
println!("{:E}", 12.34); // => 1.234E1
```

## 参考
 - [【Rust入門】文字列を出力する（Print!、Println!、format!）](https://colorfulcompany.com/rust/print)
 - [[Rust] 文字列のフォーマット指定（println! / format!）](https://qiita.com/YusukeHosonuma/items/13142ab1518ccab425f4)
