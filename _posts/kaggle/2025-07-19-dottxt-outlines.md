---
layout: post
title: "outlines"
date: 2025-07-19
excerpt: "outlinesの使い方"
kaggle: true
tag: ["outlines", "pydantic", "openai", "tool calling", "retrying", "image analysis"]
comments: false
sort_key: "2025-07-19"
update_dates: ["2025-07-19"]
---

# outliensの使い方

## 概要
 - outlinesはLLMを用い構造化を低失敗確率で行うためのツール

## インストール

```console
$ pip install outlines
```

## 使用例(OpenAI)

```python
import outlines
from pydantic import BaseModel, Field
from typing import Literal
import openai

class Customer(BaseModel):
    name: str = Field(..., description="日本語で表示")
    urgency: Literal["high", "medium", "low"]
    issue: str = Field(..., description="日本語で表示")

client = openai.OpenAI()
model = outlines.from_openai(client, "gpt-4.1")

customer = model(
    "Alice needs help with login issues ASAP",
    Customer
)

Customer.model_validate_json(customer)
"""
Customer(name='アリス', urgency='high', issue='ログインに関する問題が発生しており、至急対応が必要です。')
"""
```

## 使用例(Gemini)

```python
import outlines
from pydantic import BaseModel, Field
from typing import Literal, List, Optional
from google import genai
from google.genai import types

class Record(BaseModel):
    name: str = Field(..., description="名前")
    sex: Optional[str] = Field(..., description="性別")
    birthday: str = Field(..., description="生年月日")
    character: str = Field(..., description="性格")
    job: str = Field(..., description="職業")
    
class Output(BaseModel):
    rows: List[Record] = Field(..., description="レコードのリスト")
    
client = genai.Client()
model = outlines.from_gemini(client, "models/gemini-2.5-flash")

output = model(
    f"""
# 依頼
 - 以下のmarkdownのテーブルを構造化して

## markdownのテーブル

| 氏名 | 性別 | 生年月日 | 性格 | 職業 |
| :--- | :--- | :--- | :--- | :--- |
| 山田 太郎 | 男性 | 1990年4月1日 | 優しい | 会社員 |
| 佐藤 花子 | 女性 | 1995年8月15日| 明るい | 保育士 |
| 鈴木 一郎 | 男性 | 1988年12月3日| 真面目 | 公務員 |
| 高橋 さくら | 女性 | 2001年3月10日| 活発 | 大学生 |
| 伊藤 健太 | 回答なし | 1992年7月22日| 慎重 | エンジニア |
| 渡辺 直美 | 女性 | 1998年5月18日| 社交的 | デザイナー |
| 中村 雄太 | 男性 | 1985年11月30日| 穏やか | 医師 |
""",
    Output
)
resp = Output.model_validate_json(output)
# レコードのリストを表示
pd.DataFrame(resp.model_dump()["rows"])
```

## 詳細
 - [dottxt-ai.github.io/outlines](https://dottxt-ai.github.io/outlines/latest/)

