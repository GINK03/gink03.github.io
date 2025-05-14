---
layout: post
title: "openai agent workflow" 
date: 2025-05-14
excerpt: "openai agent workflow"
kaggle: true
tag: ["openai", "agent", "workflow", "python"]
comments: false
sort_key: "2025-05-14"
update_dates: ["2025-05-14"]
---

# openai anget workflow


## 概要
 - openai agentでworkflowを扱う場合は Runner で得られた resultをagentを変え次のRunnerに渡すことで、状態を渡すことができる
   - CrewAIのような明示的な依存関係はない

## 具体例

```python
from __future__ import annotations

import json
import random

from agents import Agent, HandoffInputData, Runner, function_tool, handoff, trace
from agents.extensions import handoff_filters


@function_tool
def random_number_tool(min: int, max: int) -> int:
    """Return a random integer between 0 and the given maximum."""
    return random.randint(min, max)


def handoff_message_filter(handoff_message_data: HandoffInputData) -> HandoffInputData:
    # we'll remove any tool-related messages from the message history
    handoff_message_data = handoff_filters.remove_all_tools(handoff_message_data)
    return HandoffInputData(
        input_history=handoff_message_data.input_history,
        pre_handoff_items=tuple(handoff_message_data.pre_handoff_items),
        new_items=tuple(handoff_message_data.new_items),
    )


first_agent = Agent(
    name="Assistant",
    instructions="Be extremely concise.",
    tools=[random_number_tool],
)

japanese_agent = Agent(
    name="Japanese Assistant",
    instructions="You only speak Japanese and are extremely concise. Use emojis😊",
    handoff_description="A Japanese-speaking assistant.",
)

second_agent = Agent(
    name="Assistant",
    instructions=(
        "Be a helpful assistant. If the user speaks Japanese, handoff to the Japanese assistant."
    ),
    handoffs=[handoff(japanese_agent, input_filter=handoff_message_filter)],
)

async def main():
    with trace(workflow_name="Message filtering"):
        result = await Runner.run(first_agent, input="Hi, my name is Sora.")
        print("Step 1 done")

        result = await Runner.run(
            first_agent,
            input=result.to_input_list()
            + [ {"content": "Can you generate a random number between -100 and 100?", "role": "user"} ],
        )
        print("Step 2 done")

        result = await Runner.run(
            second_agent,
            input=result.to_input_list()
            + [ { "content": "I live in New York City. Whats the population of the city?", "role": "user", } ],
        )
        print("Step 3 done")

        result = await Runner.run(
            second_agent,
            input=result.to_input_list()
            + [ { "content": "東京の人口はどうですかね？", "role": "user", } ],
        )
        print("Step 4 done")

        result = await Runner.run(
            second_agent,
            input=result.to_input_list()
            + [ { "content": "it is pretty hot.", "role": "user", } ],
        )
        print("Step 5 done")

        result = await Runner.run(
            second_agent,
            input=result.to_input_list()
            + [ { "content": "今、東京にいるけどゲロみたいに暑いよ！", "role": "user", } ],
        )
        print("Step 6 done")

    print("\n===Final messages===\n")

    for message in result.to_input_list():
        print(json.dumps(message, indent=2, ensure_ascii=False))

await main()
"""
Step 1 done
Step 2 done
Step 3 done
Step 4 done
Step 5 done
Step 6 done

===Final messages===

{
  "content": "Hi, my name is Sora.",
  "role": "user"
}
{
  "id": "msg_682446d4393081919b7792cdc27aeee40a82e1ce0df988a1",
  "content": [
    {
      "annotations": [],
      "text": "Hi Sora! How can I assist you today?",
      "type": "output_text"
    }
  ],
  "role": "assistant",
  "status": "completed",
  "type": "message"
}
{
  "content": "Can you generate a random number between -100 and 100?",
  "role": "user"
}
{
  "id": "msg_682446d63bbc81918ce04284c82628bf0a82e1ce0df988a1",
  "content": [
    {
      "annotations": [],
      "text": "The random number is 1.",
      "type": "output_text"
    }
  ],
  "role": "assistant",
  "status": "completed",
  "type": "message"
}
{
  "content": "I live in New York City. Whats the population of the city?",
  "role": "user"
}
{
  "id": "msg_682446d74a548191ba430222f090cf9b0a82e1ce0df988a1",
  "content": [
    {
      "annotations": [],
      "text": "As of the latest estimates, New York City's population is approximately 8.8 million people. However, this number can change, so it's a good idea to check the most recent statistics for the latest information.",
      "type": "output_text"
    }
  ],
  "role": "assistant",
  "status": "completed",
  "type": "message"
}
{
  "content": "東京の人口はどうですかね？",
  "role": "user"
}
{
  "id": "msg_682446d9e2b4819197ce7690474346b20a82e1ce0df988a1",
  "content": [
    {
      "annotations": [],
      "text": "東京の人口は約1,400万人です。🏙️",
      "type": "output_text"
    }
  ],
  "role": "assistant",
  "status": "completed",
  "type": "message"
}
{
  "content": "it is pretty hot.",
  "role": "user"
}
{
  "id": "msg_682446db2b448191a1cbd33f50509d660a82e1ce0df988a1",
  "content": [
    {
      "annotations": [],
      "text": "It can get quite warm! Are you looking for ways to stay cool, or do you need any tips for handling the heat?",
      "type": "output_text"
    }
  ],
  "role": "assistant",
  "status": "completed",
  "type": "message"
}
{
  "content": "今、東京にいるけどゲロみたいに暑いよ！",
  "role": "user"
}
{
  "id": "msg_682446ddc7888191a515b373750db14a0a82e1ce0df988a1",
  "content": [
    {
      "annotations": [],
      "text": "暑いですよね！😅 涼しい場所で水分をしっかりとってね。☀️💧",
      "type": "output_text"
    }
  ],
  "role": "assistant",
  "status": "completed",
  "type": "message"
}
"""
```
