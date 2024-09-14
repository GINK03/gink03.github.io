---
layout: post
title: "bigquery string"
date: 2020-06-26
excerpt: "bigqueryの文字列関連のチートシート"
tags: ["bq", "bigquery", "gcp"]
kaggle: true
comments: false
sort_key: "2022-09-09"
update_dates: ["2022-09-09"]
---

# bigqueryの文字列関連のチートシート

## LOWER

```sql
(SELECT
  'FOO' as item
UNION ALL
SELECT
  'BAR' as item
UNION ALL
SELECT
  'BAZ' as item)

SELECT
  LOWER(item) AS example
FROM items;

+---------+
| example |
+---------+
| foo     |
| bar     |
| baz     |
+---------+
```

## CONCAT

```sql
SELECT CONCAT('T.P.', ' ', 'Bar') as author;

+---------------------+
| author              |
+---------------------+
| T.P. Bar            |
+---------------------+
```

## CHAR_LENGTH
 - 文字列の長さを返す(バイト数ではないので日本語でも正しくカウントされる)

```sql
SELECT CHAR_LENGTH('あいうえお') as length;

+--------+
| length |
+--------+
| 5      |
+--------+
```

## SPLIT + SAFE_OFFSET
 - 特定の文字で分割してリストとして要素でアクセスする
 - 指定したインデックスが存在しない場合に安全に扱うために`SAFE_OFFSET`関数がある
   - 例外時には`null`が帰る

```sql
SELECT
  name,
  SPLIT(email, "@")[SAFE_OFFSET(1)] as domain
FROM UNNEST([
  STRUCT("山田 太郎" as name, "taro.yamada@example.com" as email),
  ("佐藤 花子", "hanako.sato@example.com"),
  ("鈴木 一郎", "ichiro.suzuki@example.com"),
  ("田中 二郎", "jiro.tanaka@example.com"),
  ("高橋 三郎", "a-illigal-email-address")
])
```

| name      | domain      |
|-----------|-------------|
| 山田 太郎 | example.com |
| 佐藤 花子 | example.com |
| 鈴木 一郎 | example.com |
| 田中 二郎 | example.com |
| 高橋 三郎 |             |

## REGEXP_CONTAINS
 - 正規表現にマッチしたらどうかという真偽値を返す

```sql
SELECT REGEXP_CONTAINS("ポケモンゲットだぜ", "(ゲットだぜ)")  -- true
```

## REGEXP_EXTRACT, REGEXP_EXTRACT_ALL
 - 正規表現で一致した内容をパースする
 - `REGEXP_EXTRACT_ALL`はすべてパースする(nestしたレコードになるので、最終的にUNNESTの操作が必要)

**具体例**
```sql
SELECT
  id,
  name,
  email,
  REGEXP_EXTRACT(email, r"^([a-zA-Z0-9]{1,})@") as email_prefix, -- emailのプレフィックスにマッチする
FROM UNNEST([
  STRUCT("abc" AS name, "abc@google.com" as email, 1 AS id),
  ("abcd", "abc@microsoft.com", 2),
  ("例子", "reiko@google.com", 4),
  ("例夫", "reio@yahoo.com", 10),
  ("例ちゃん", "reichan@aol.com", 15)
])
```

## REGEXP_REPLACE
 - マッチした部分を別の文字に置き換える
 - REPLACE関数だと何度もネストする必要があるような場合に簡潔に記せる

```sql
SELECT
  REGEXP_REPLACE(text, r"^prefix1|^prefix2|^prefix3", "") as text
```

---

## 参考
 - [文字列関数/Google Cloud](https://cloud.google.com/bigquery/docs/reference/standard-sql/string_functions?hl=ja)
