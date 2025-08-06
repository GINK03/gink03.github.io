---
layout: post
title: "python browser use"
date: 2025-08-06
excerpt: "browser useのログイン認証の使い方"
config: true
tag: ["python", "browser use", "playwright"]
comments: false
sort_key: "2025-08-06"
update_dates: ["2025-08-06"]
---

# python browser useのログイン認証の使い方

## 概要
 - 特定のサイトにログインする方法は以下の二種類
   1. `sensitive_data`を使いエージェントにログイン情報を渡す方法
   2. 事前にユーザサイドでログインしておき、cookieをbrowser useに渡す方法
 - `sensitive_data` は LLMは直接参照しなく、エージェントがブラウザセッションに渡し後に置き換えられる

## 1. `sensitive_data`を使いエージェントにログイン情報を渡す方法

```python
import asyncio
from browser_use import Agent
from browser_use.llm import ChatGoogle
from browser_use.browser.browser import Browser, BrowserConfig, BrowserSession


browser_session = BrowserSession(allowed_domains=['https://*.rakuten.co.jp', 'https://*.rakuten.com'],
                                 chromium_sandbox=False,
                                 start_url="https://travel.rakuten.co.jp/")

sensitive_data = {
    'https://*.rakuten.co.jp': {
        'x_member_number': 'example@example.com',
        'x_passphrase': 'your_password_here',
    },
    'https://*.rakuten.com': {
        'x_member_number': 'example@example.com',
        'x_passphrase': 'your_password_here',
    },
}

async def main():
    task = """
# ログインしていなかった場合の追加依頼
 - 1. https://grp01.id.rakuten.co.jp へアクセス
 - 2. x_member_number と x_passphrase でログイン

# 基本依頼
 - 1. https://point.rakuten.co.jp/ へアクセス
 - 2. ポイントを確認してユーザに伝達

# 制限
 - Google検索、Bing検索は禁止
"""

    llm = ChatGoogle(
        model="gemini-2.5-flash", 
        temperature=0.5,
    )

    agent = Agent(task=task,
                  llm=llm,
                  browser_session=browser_session,
                  sensitive_data=sensitive_data,
                  # use_vision=False, # ログイン用途ではSSに個人情報が映る可能性があるので、Agent(use_vision=False) を推奨
                  max_actions_per_step=4,)
    return await agent.run(max_steps=20)

history = await main()
```

## 2. 事前にユーザサイドでログインしておき、cookieをbrowser useに渡す方法

**ブラウザを起動してログインしておく**

```console
$ playwright open https://grp01.id.rakuten.co.jp --save-storage ./rakuten.json # chromiumが起動
```

**ブラウザセッションにcookieを渡す**

```python
import asyncio
from browser_use import Agent
from browser_use.llm import ChatGoogle
from browser_use.browser.browser import Browser, BrowserConfig, BrowserSession


browser_session = BrowserSession(chromium_sandbox=False, 
                                 storage_state='./rakuten.json',
                                 allowed_domains=['https://*.rakuten.co.jp', 'https://*.rakuten.com'],
                                 start_url="https://travel.rakuten.co.jp/")

async def main():

    task = """
# ログインしていなかった場合の追加依頼
 - 1. https://grp01.id.rakuten.co.jp へアクセス
 - 2. x_member_number と x_passphrase でログイン

# 基本依頼
 - 1. https://point.rakuten.co.jp/ へアクセス
 - 2. ポイントを確認してユーザに伝達

# 制限
 - Google検索、Bing検索は禁止
"""

    llm = ChatGoogle(
        model="gemini-2.5-flash",
        temperature=0.5,
    )

    agent = Agent(task=task,
                  llm=llm,
                  browser_session=browser_session,
                  max_actions_per_step=4,)
    return await agent.run(max_steps=20)

history = await main()
```
