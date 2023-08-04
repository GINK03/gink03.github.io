---
layout: post
title: "langchain"
date: 2023-08-04
excerpt: "langchainの概要と使い方"
kaggle: true
tag: ["langchain", "LLM", "python"]
comments: false
sort_key: "2023-08-04"
update_dates: ["2023-08-04"]
---

# langchainの概要と使い方

## 概要
 - LLMを使いやすくするラッパー
 - 使用例の多くではopenaiが使われるが任意のLLMで使える構造になっている
 - 検索、document loader、エンベッティング、テンプレート作成、Text-to-SQLなどをサポートしている
 - experimentalな機能も多く、パッケージパスや名前空間も頻繁に変わる
 - 参考になるcookbook
   - [langchain-tutorials](https://github.com/gkamradt/langchain-tutorials)

## 基本

### Document
 - 文章を管理するデータクラス

```python
from langchain.schema import Document

Document(page_content="This is my document. It is full of text that I've gathered from other places",
         metadata={
             'my_document_id' : 234234,
             'my_document_source' : "The LangChain Papers",
             'my_document_create_time' : 1680013019
         })
```

### llm
 - LLMの入力、出力のラッパー

```python
from langchain.llms import OpenAI

llm = OpenAI(model_name="text-ada-001", openai_api_key=openai.api_key)
llm("What day comes after Friday?")
# \n\nSaturday.
```

### embedding
 - エンベッティング  

```python
from langchain.embeddings import OpenAIEmbeddings
embeddings = OpenAIEmbeddings(openai_api_key=openai_api_key)

text = "Hi! It's time for the beach"
text_embedding = embeddings.embed_query(text)

print(f"Your embedding is length {len(text_embedding)}")
print(f"Here's a sample: {text_embedding[:5]}...")
# Your embedding is length 1536
# Here's a sample: [-0.00011466222223832393, -0.0031506525609423463, -0.0007831145605424049, -0.019504328350815368, -0.01512555857422201]...
```

### PromptTemplate
 - プロンプトのテンプレート

```python
from langchain.llms import OpenAI
from langchain import PromptTemplate

llm = OpenAI(model_name="text-davinci-003", openai_api_key=openai_api_key)

# Notice "location" below, that is a placeholder for another value later
template = """
I really want to travel to {location}. What should I do there?

訪れるべき都市を日本語で一行で教えてください。
"""

prompt = PromptTemplate(
    input_variables=["location"],
    template=template,
)

final_prompt = prompt.format(location='東京')

print(f"Final Prompt: {final_prompt}")
print("-----------")
print(f"LLM Output: {llm(final_prompt)}")

"""
Final Prompt: 
I really want to travel to Japan. What should I do there?

訪れるべき都市を日本語で一行で教えてください。

-----------
LLM Output: 東京
"""
```

### output_parser
 - markdownのjsonコードスニペット形式の出力をパースする  

```python
from langchain.output_parsers import StructuredOutputParser, ResponseSchema
from langchain.prompts import ChatPromptTemplate, HumanMessagePromptTemplate
from langchain.llms import OpenAI

llm = OpenAI(model_name="text-davinci-003", openai_api_key=openai_api_key)
response_schemas = [
    ResponseSchema(name="bad_string", description="This a poorly formatted user input string"),
    ResponseSchema(name="good_string", description="This is your response, a reformatted response")
]
output_parser = StructuredOutputParser.from_response_schemas(response_schemas)

format_instructions = output_parser.get_format_instructions()
print(format_instructions)

template = """
You will be given a poorly formatted string from a user.
Reformat it and make sure all the words are spelled correctly

{format_instructions}

% USER INPUT:
{user_input}

YOUR RESPONSE:
"""
prompt = PromptTemplate(
    input_variables=["user_input"],
    partial_variables={"format_instructions": format_instructions},
    template=template
)
promptValue = prompt.format(user_input="welcom to califonya!")
llm_output = llm(promptValue)
output_parser.parse(llm_output)
"""
{'bad_string': 'welcom to califonya!', 'good_string': 'Welcome to California!'}
"""
```
