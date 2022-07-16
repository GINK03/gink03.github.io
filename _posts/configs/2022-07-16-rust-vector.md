---
layout: post
title: "rust vector" 
date: "2022-07-16"
excerpt: "rust vectorの使い方"
config: true
tag: ["rust", "vector"]
comments: false
sort_key: "2022-07-16"
update_dates: ["2022-07-16"]
---

# rust vectorの使い方

## 概要
 - 初期化の仕方がいくつかある
   - `vec![]`マクロによる初期化
   - iteratorをcollectする方法
 - インデックスアクセスは負の値は取れない
 - インデックスにはiteratorを引数に取ることができる
 - popはoptional型

## 具体例

```rust
fn main() {
    // iteratorをコレクトするとvectorになる
    let a0: Vec<i32> = (0..10).collect();

    // {:?}でデバック書き出し
    println!("Collected (0..10) into: {:?}", a0);

    // vec![]マクロでもvectorを定義できる
    let mut a0 = vec![1i32, 2, 3];

    // 末尾に追加
    a0.push(4);
    println!("{:?}", a0);

    // 長さ
    println!("len = {}", a0.len());

    // pop, pythonのpopと同じ
    println!("pop result = {:?}", a0.pop());

    // すべての要素をiterate
    for a in a0.iter() {
        println!("iter = {}", a);
    }

    // 内容の変更を明示してiterate
    for a in a0.iter_mut() {
        *a *= 2;
    }
    println!("iter_mut result = {:?}", a0); // [2, 4, 6]

    // iteratorを引数に取ることができる
    println!("slice vector = {:?}", &a0[0..2]); // [2, 4]

    // vectorのコピー
    let mut a1 = a0.clone();
    for a in a1.iter_mut() {
        *a *= 100;
    }
    println!("a0 = {:?}", a0); // [2, 4, 6]
    println!("a1 = {:?}", a1); // [200, 400, 600]
}
```

## 参考
 - [ベクタ型/Rust By Example 日本語版](https://doc.rust-jp.rs/rust-by-example-ja/std/vec.html)
