---
layout: post
title: "openai organizations" 
date: 2023-07-09
excerpt: "openai organizationsの概念"
kaggle: true
tag: ["openai", "chatgpt"]
comments: false
sort_key: "2023-07-09"
update_dates: ["2023-07-09"]
---

# openai organizationsの概念

## 概要
 - APIにリクエストするときにヘッダーに`organization id`を指定すると組織の割当に対して課金される
 - API keyの発行主体が個人
 - 個人は複数の組織に属することができるので、一つのAPIキーを使用しつつ`organization id`を指定することで課金先を変えることができる

## 具体例

**console**
```console
$ curl https://api.openai.com/v1/models \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "OpenAI-Organization: $USING_ORGANIZATION_ID"
```

**python**
```python
import os
import openai
openai.organization = os.getenv("USING_ORGANIZATION_ID")
openai.api_key = os.getenv("OPENAI_API_KEY")
openai.Model.list()
```

## 参考
 - [Requesting organization](https://platform.openai.com/docs/api-reference/requesting-organization)
 - [Organization、Member、API keyの関係について](https://zenn.dev/hokawa/articles/dd1a18c9192fc9)
