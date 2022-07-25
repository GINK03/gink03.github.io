---
layout: post
title: "rust option" 
date: "2022-07-25"
excerpt: "rust optionの使い方"
config: true
tag: ["rust", "option"]
comments: false
sort_key: "2022-07-25"
update_dates: ["2022-07-25"]
---

# rust optionの使い方

## 概要
 - PythonのOptionalと同じ
 - 値の取り出し方にいくつか方法がある
   - `match`で取り出す
   - `if let ~`で取り出す
   - `.unwrap()`で取り出す

## 具体例

**matchで取り出す**
```rust
let val: Option<String> = None;
let a = match val {
    Some(x) => "exists",
    None => "nothing",
};
```

**if letで取り出す**  
```rust
let val = if let Some(val) = val {
    val
} else {
    String::from("nothing")
};
```

## 参考
 - [Enum std::option::Option/rust-lang.org](https://doc.rust-lang.org/std/option/enum.Option.html)


