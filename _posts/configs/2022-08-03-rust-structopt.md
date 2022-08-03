---
layout: post
title: "rust structopt" 
date: "2022-08-03"
excerpt: "rust structoptの使い方"
config: true
tag: ["rust", "structopt", "argparse", "引数"]
comments: false
sort_key: "2022-08-03"
update_dates: ["2022-08-03"]
---

# rust structoptの使い方

## 概要
 - 3rd partyの引数ハンドルライブラリ
   - `use structopt::StructOpt;`
 - 引数でどんなものを期待するかというstructを定義することで、引数を簡単に扱える
   - `#[derive(StructOpt)]`, `#[structopt(name = "basic")]`

## 使用の具体例

```rust
use structopt::StructOpt;

fn main() {
    let opt = Opt::from_args();
    println!("opt.name = {}", opt.name);
    println!("opt.greet = {}", opt.greet);
    println!("opt.unchi_num = {}", opt.unchi_num);

    if let Some(a) = opt.optstring {
        println!("optional argument working, opt.optstring = {}", a);
    }
}

// A basic example
#[derive(StructOpt)]
#[structopt(name = "basic")]
struct Opt {
    // 名前無しで引数を与える場合
    unchi_num: i32,

    // 指定されなかった場合のデフォルト値を設置
    #[structopt(short = "n", long = "name", default_value="うんちちゃん")]
    name: String,

    // 環境変数を読み込むこともできる
    #[structopt(short = "g", default_value = "Hello", env = "GREET")]
    greet: String,

    // 指定されなかった場合、Noneになる
    #[structopt(short = "o", long = "optstring")]
    optstring: Option<String>,
}
```

### 実行例

```console
$ GREET="環境変数から" cargo run -- 10 --optstring="ふが"
opt.name = うんちちゃん
opt.greet = 環境変数から
opt.unchi_num = 10
optional argument working, opt.optstring = ふが
```
 - cargoで実行する場合、引数を与えるにはハイフン2回が必要

### `Cargo.toml`

```toml
[dependencies]
structopt = "*"
```

---

## 参考
 - [Crate structopt](https://docs.rs/structopt/latest/structopt/)
 - [Rust で structopt で簡単 CLI ツール](https://qiita.com/Yappii_111/items/4ac93029d3a661d9e64a)
