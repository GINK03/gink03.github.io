---
layout: post
title: "python jinja2"
date: "2023-08-05"
excerpt: "pythonのjinja2の使い方"
project: false
config: true
tag: ["python", "jinja2", "template"]
comments: false
sort_key: "2023-08-05"
update_dates: ["2023-08-05"]
---

# pythonのjinja2の使い方

## 概要
 - pythonで利用できるtemplate
 - HTMLを生成する際にも使えるが、SQLなどもテンプレート化できる
 - 単なる変数の代入だけでなく、ループや制御構文も使える

## 基本的な使い方

### プレースホルダーに代入する

```python
from jinja2 import Template

template = Template("""
SELECT
    id,
    user_id
FROM
    {{ user_table }}
""")

sandbox_config = {"user_table": "sandbox.user_table"}

print(template.render(**sandbox_config))
"""
SELECT
    id,
    user_id
FROM
    sandbox.user_table
"""
```

### ループを使用する
 - タグの前後に`-`をつけると空白と改行が削除されるホワイトスペース制御機能を用いる

```python
from jinja2 import Template

template = Template("""
SELECT
    {% for column in columns -%}
      { { column } }{ % if not loop.last % }, { % endif % }
    {%- endfor %}
FROM
    {{ table_name }};
""")

columns = ["id", "name", "age"]
table_name = "users"

print(template.render(columns=columns, table_name=table_name))
"""
SELECT
    id, name, age
FROM
    users;
"""
```

### エスケープ文字を変更

```python
from jinja2 import Environment

jinja_env = Environment(
    variable_start_string='[[',
    variable_end_string=']]',
)

template = jinja_env.from_string("こんにちは、[[ name ]]さん")
print(template.render(**{"name": "山田"}))
"""
こんにちは、山田さん
"""
```

## 参考
 - [Jinja — Jinja Documentation (3.1.x)](https://jinja.palletsprojects.com/en/3.1.x/)
