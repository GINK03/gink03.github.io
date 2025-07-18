---
layout: post
title: "instructor"
date: 2024-10-21
excerpt: "instructorの使い方"
kaggle: true
tag: ["instructor", "openai", "nlp"]
comments: false
sort_key: "2024-10-21"
update_dates: ["2024-10-21"]
---

# instructorの使い方

## 概要
 - openaiのtool callingをpydanticで呼び出せるようにしたライブラリ
 - たまに構造化に失敗するので、リトライ機能が必要になることがある
 - openrouter経由でも利用可能

## インストール

```console
$ pip install instructor
```

## 使用例

**基本**
```python
import openai
import instructor
from pydantic import BaseModel, Field
from tenacity import Retrying, stop_after_attempt, wait_fixed

client = instructor.from_openai(
    openai.OpenAI(),
    model="gpt-4.1",
    temperature=0.0,
    mode=instructor.Mode.TOOLS
)

class Output(BaseModel):
    name: str = Field(..., description="The name of the person")
    age: int = Field(..., description="The age of the person")

response = client.chat.completions.create(
    model="gpt-4-turbo-preview",
    response_model=Output,
    messages=[
        {"role": "user", "content": "Extract `jason is 12`"},
    ],
    max_retries=Retrying(
        stop=stop_after_attempt(6), # 試行回数  
        wait=wait_fixed(1), # 待機時間
    ),  
)
print(response.model_dump_json(indent=2))
"""
{
  "name": "jason",
  "age": 12
}
"""
```

**画像の分析**

```python
import base64
import os
from enum import Enum
from io import BytesIO
from typing import Iterable
from typing import List
from typing import Literal, Optional

import instructor
import pandas as pd
from openai import OpenAI
from pydantic import BaseModel, Field

class RoleEnum(str, Enum):
    CEO = "CEO"
    CTO = "CTO"
    CFO = "CFO"
    COO = "COO"
    EMPLOYEE = "Employee"
    MANAGER = "Manager"
    INTERN = "Intern"
    OTHER = "Other"

class Employee(BaseModel):
    employee_name: str = Field(..., description="The name of the employee")
    role: RoleEnum = Field(..., description="The role of the employee")
    manager_name: Optional[str] = Field(None, description="The manager's name, if applicable")
    manager_role: Optional[RoleEnum] = Field(None, description="The manager's role, if applicable")


class EmployeeList(BaseModel):
    employees: List[Employee] = Field(..., description="A list of employees")

def parse_orgchart(base64_img: str) -> EmployeeList:
    response = instructor.from_openai(OpenAI()).chat.completions.create(
        model='gpt-4o',
        response_model=EmployeeList,
        messages=[
            {
                "role": "user",
                "content": 'Analyze the given organizational chart and very carefully extract the information.',
            },
            {
                "role": "user",
                "content": [
                    {
                        "type": "image_url",
                        "image_url": {
                            "url": f"data:image/jpeg;base64,{base64_img}"
                        }
                    },
                ],
            }
        ],
    )
    return response

def encode_image(image_path: str):
    if not os.path.exists(image_path):
        raise FileNotFoundError(f"Image file not found: {image_path}")
    with open(image_path, "rb") as image_file:
        return base64.b64encode(image_file.read()).decode('utf-8')

base64_img = encode_image("data/canva-minimalist-colorful-organizational-structure-list-graph-aVPmYwxJYMU.jpg")
result = parse_orgchart(base64_img)

# tabulate the extracted data
df = pd.DataFrame([{
    'employee_name': employee.employee_name,
    'role': employee.role.value,
    'manager_name': employee.manager_name,
    'manager_role': employee.manager_role.value if employee.manager_role else None
} for employee in result.employees])

df
"""
| employee_name   | role     | manager_name   | manager_role   |
|:----------------|:---------|:---------------|:---------------|
| Juliana Silva   | CEO      |                |                |
| Kim Chun Hei    | CFO      | Juliana Silva  | CEO            |
| Chad Gibbons    | CTO      | Juliana Silva  | CEO            |
| Chiaki Sato     | COO      | Juliana Silva  | CEO            |
| Cahaya Dewi     | Manager  | Kim Chun Hei   | CFO            |
| Shawn Garcia    | Manager  | Chad Gibbons   | CTO            |
| Aaron Loeb      | Manager  | Chiaki Sato    | COO            |
| Drew Feig       | Employee | Cahaya Dewi    | Manager        |
| Richard Sanchez | Employee | Cahaya Dewi    | Manager        |
| Olivia Wilson   | Employee | Shawn Garcia   | Manager        |
| Avery Davis     | Employee | Aaron Loeb     | Manager        |
| Harper Russo    | Employee | Aaron Loeb     | Manager        |
| Sacha Dubois    | Intern   | Drew Feig      | Employee       |
| Matt Zhang      | Intern   | Olivia Wilson  | Employee       |
| Taylor Alonso   | Intern   | Harper Russo   | Employee       |
"""
```

## 参考
 - [Structured outputs with OpenRouter, a complete guide with instructor](https://python.useinstructor.com/integrations/openrouter/)

