---
layout: post
title: "rustのstring"
date: "2022-07-06"
excerpt: "rustのstringの使い方"
config: true
tag: ["rust", "string"]
comments: false
sort_key: "2022-07-06"
update_dates: ["2022-07-06"]
---

## 概要
 - primitive型の`str`と、`String`がある

## 具体例

```rust
fn main() {
    // primitive型の変数の宣言
    let s0: &str = "unchi!";

    // 変更可能なString型の宣言
    let mut s1: String = String::from("super unchi!");

    // 文字を追加
    s1 += "-chan!!";

    // formatマクロで結合
    let s2 = format!("夏は熱いね、{}", "うんちちゃん");

    // Stringをcharのarrayに変換
    let cs: Vec<char> = s2.chars().collect();

    println!("s0 = {}, s1 = {}, s2 = {}", s0, s1, s2);

    // lenはbyte単位の長さになる
    println!("len = {}", "💓".len()); // len = 4

    // sizeは文字の長さになる
    println!("size = {}", "💓".chars().count()); // size = 1

    // 数字の文字列のパース
    let num = match "1234567".parse() {
        Ok(num) => num,
        Err(_) => -1,
    };
    println!("num = {}", num);

    // セパレータで分割
    "a-b-c".split('-').collect::<Vec<_>>(); // => ["a", "b", "c"]
}
```

## 参考
 - [【Rust入門】文字列の使い方（strとString）](https://colorfulcompany.com/rust/str-and-string)
 - [Ruby脳のためのRust文字列系メソッドまとめ](https://zenn.dev/megeton/articles/895e0547645e03)
