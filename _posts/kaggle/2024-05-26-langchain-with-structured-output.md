---
layout: post
title: "langchain with structured output"
date: 2024-05-26
excerpt: "langchain with structured output"
kaggle: true
tag: ["langchain", "LLM", "python"]
comments: false
sort_key: "2024-05-26"
update_dates: ["2024-05-26"]
---

# langchain with structured output

## 概要
 - 特定の構造化形式で出力を強制する機能
 - pydanticを使用して構造化された出力を定義
 - openai, google-genaiで使用可能

## インストール

```console
$ pip install langchain-openai langchain-google-genai
```

## 使用例

```python
from typing import Optional
from langchain_openai import ChatOpenAI
from langchain_core.pydantic_v1 import BaseModel, Field

class Claim(BaseModel):
    title: str = Field(description="あなたが考える記事のタイトル(30文字程度)")
    claim_jp: Optional[str] = Field(None, description="1行で示す記事の主張(日本語, その1)")
    claim_en: Optional[str] = Field(None, description="1行で示す記事の主張(英語, その1)")
    is_fact: bool = Field(None, description="あなたが考えるファクトかどうか")
    not_fact_point: Optional[str] = Field(None, description="ファクトではないと考えた場合、どのような箇所が怪しいと考えたかを１行程度で説明")

def make_structured(content: str):
    prompt = "与えられたニュース記事の情報を、Googleでファクトチェックするためにクエリにする主張を１行で抜き出してください。" \
            "翻訳が必要ならば日本語英語それぞれに翻訳し、適切に構造化してください。" \
            "またあなたが考えるファクトかどうかをbooleanで答えてください。: \n {content}"
    llm = ChatOpenAI(model="gpt-4o", temperature=0) # openaiのモデルを指定
    llm = ChatGoogleGenerativeAI(model="gemini-1.5-flash",) # google-genaiのモデルを指定
    structured_llm = llm.with_structured_output(Claim)
    res = structured_llm.invoke(prompt.format(content=content))
    return res

cs = [claim.dict() for claim in [make_structured("ドナルド・トランプが電子銃で暗殺された"), 
                                 make_structured("2023年日銀の金融緩和が行き過ぎてハイパーインフレーションに陥った"), ]]
print(pd.DataFrame(cs).to_markdown(index=False))

"""
| title                                                            | claim_jp                                                                   | claim_en                                                                                | is_fact   | not_fact_point                                                                                           |
|:-----------------------------------------------------------------|:---------------------------------------------------------------------------|:----------------------------------------------------------------------------------------|:----------|:---------------------------------------------------------------------------------------------------------|
| ドナルド・トランプが電子銃で暗殺された                           | ドナルド・トランプが電子銃で暗殺された                                     | Donald Trump was assassinated with an electronic gun                                    | False     | この主張は非常に信じがたく、信頼性のある情報源からの確認が必要です。                                     |
| 2023年日銀の金融緩和が行き過ぎてハイパーインフレーションに陥った | 2023年、日銀の金融緩和が行き過ぎて日本はハイパーインフレーションに陥った。 | In 2023, excessive monetary easing by the Bank of Japan led to hyperinflation in Japan. | False     | ハイパーインフレーションは非常に稀な現象であり、通常は極端な経済状況でしか発生しないため、信憑性が低い。 |
"""
```

## 参考
 - [LangChain `with_structured_output` メソッドによる構造化データ抽出](https://zenn.dev/ml_bear/articles/cb07549ec52175)
