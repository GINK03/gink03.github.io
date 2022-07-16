---
layout: post
title: "rust assert" 
date: "2022-07-16"
excerpt: "rust assertの使い方"
config: true
tag: ["rust", "assert"]
comments: false
sort_key: "2022-07-16"
update_dates: ["2022-07-16"]
---

# rust assertの使い方

## 概要
 - rustでのassertの使い方
 - pythonのassertと似ている
   - 失敗時に示すメッセージになる
 - `std::assert`なので外部ライブラリ等は必要ない

## 具体例

```rust
fn some_computation() -> bool { true } // a very simple function

fn main() {
    assert!(true);

    assert!(some_computation());

    // assert with a custom message
    let x = true;
    assert!(x, "x wasn't true!");

    let a = 3; let b = 27;
    assert!(a + b == 30, "a = {}, b = {}", a, b);
}
```

## 参考
 - [Macro std::assert/doc.rust-lang.org](https://doc.rust-lang.org/std/macro.assert.html)
 - [テストの記述法/The Rust Programming Language 日本語版](https://doc.rust-jp.rs/book-ja/ch11-01-writing-tests.html)
