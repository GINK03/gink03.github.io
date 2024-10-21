---
layout: post
title: "instructor batch"
date: 2024-10-21
excerpt: "instructor batchの使い方"
kaggle: true
tag: ["instructor", "openai", "nlp"]
comments: false
sort_key: "2024-10-21"
update_dates: ["2024-10-21"]
---

# instructor batchの使い方

## 概要
 - openaiのAPIをバッチで利用するためのライブラリ
 - 型情報はpydanticを利用している
 - 以下のプロセスに分けて処理を行う
   - バッチ処理を行うための設定情報を作成する
   - バッチ処理を実行する
   - バッチ処理の結果を取得する
   - 結果をパースする

## インストール

```console
$ pip install instructor
```

## 使用例


**バッチ処理を行うための設定情報を作成する**
 - `test.jsonl` というファイル名で出力される

```python
from datasets import load_dataset
from instructor.batch import BatchJob
from pydantic import BaseModel, Field

dataset = load_dataset("ms_marco", "v1.1", split="train", streaming=True).take(10)

def get_messages(dataset):  
    for row in dataset:
        for passage in row['passages']['passage_text']:
            yield [
                {
                    "role": "system",
                    "content": "あなたは、仮説的な検索クエリを生成することに優れた世界クラスの AI です。テキスト スニペットが与えられようとしており、与えられる特定のテキスト チャンクに固有の検索クエリを日本語で生成するように求められます。必ずテキスト チャンクの情報を使用してください。",
                },
                {"role": "user", "content": f"Here is the text chunk: {passage}"},
            ]

class QuestionAnswerPair(BaseModel):
    chain_of_thought: str = Field(
        description="The reasoning process leading to the answer in Japanese."
    )
    question: str = Field(description="The generated question from the text chunk in Japanese.")
    answer: str = Field(description="The answer to the generated question in Japanese.")

BatchJob.create_from_messages(
    messages_batch=get_messages(dataset),
    model="gpt-4o-mini",
    file_path="./test.jsonl",
    response_model=QuestionAnswerPair,
)
```

**バッチ処理を実行する**

```console
$ instructor batch create-from-file --file-path test.jsonl
                                            OpenAI Batch Jobs
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━┳━━━━━━━━┳━━━━━━━━━━━┳━━━━━━━┓
┃ Batch ID                               ┃ Created At          ┃ Status    ┃ Failed ┃ Completed ┃ Total ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━╇━━━━━━━━╇━━━━━━━━━━━╇━━━━━━━┩
│ batch_6715d871981081909672713310278aa6 │ 2024-10-21 13:28:33 │ completed │ 0      │ 89        │ 89    │
│ batch_6715b238a9588190973b2674944ba97f │ 2024-10-21 10:45:28 │ completed │ 0      │ 89        │ 89    │
│ batch_PtzpGTAOmadVeJscmcWeTR7K         │ 2024-07-24 20:40:09 │ completed │ 0      │ 3         │ 3     │
│ batch_NxLfIAf4VA4Wi0MI2AerSlV7         │ 2024-07-24 19:05:25 │ completed │ 0      │ 3         │ 3     │
│ batch_xQEUsqZ6A2IezdWk7kV3TNQ6         │ 2024-07-02 00:21:27 │ completed │ 0      │ 3         │ 3     │
└────────────────────────────────────────┴─────────────────────┴───────────┴────────┴───────────┴───────┘
```

**バッチ処理の結果を取得する**
 - `output.jsonl` というファイル名で出力される

```console
$ instructor batch download-file --download-file-path output.jsonl --batch-id batch_6715d871981081909672713310278aa6
```

**結果をパースする**

```python
from instructor.batch import BatchJob
from pydantic import BaseModel, Field

class QuestionAnswerPair(BaseModel):
    chain_of_thought: str = Field(
        description="The reasoning process leading to the answer."
    )
    question: str = Field(description="The generated question from the text chunk.")
    answer: str = Field(description="The answer to the generated question.")

parsed, unparsed = BatchJob.parse_from_file(  
    file_path="./output.jsonl", response_model=QuestionAnswerPair
)
parsed = pd.DataFrame([p.dict() for p in parsed])
```

## 参考
 - [Bulk Generation of Synthetic Data - Instructor](https://python.useinstructor.com/examples/batch_job_oai/)
