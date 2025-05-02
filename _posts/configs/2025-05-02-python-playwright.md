---
layout: post
title: "python playwright"
date: 2025-05-02
excerpt: "python playwrightの使い方"
config: true
tag: ["python", "playwright"]
comments: false
sort_key: "2025-05-02"
update_dates: ["2025-05-02"]
---

# python playwrightの使い方

## 概要
 - pythonからplaywrightが使えるツール

## インストール

```console
$ pip install playwright
$ playwright install # apt-get install libgstreamer-plugins-bad1.0-0 libavif16 が必要な場合がある
```

## サンプル

### 特定ページのスクリーンショットを撮る

```python
from playwright.async_api import async_playwright, TimeoutError as PlaywrightTimeoutError

async def capture_after_5s(url: str, output_path: str, width: int, height: int):
    async with async_playwright() as pw:
        browser = await pw.chromium.launch(headless=True)
        context = await browser.new_context(
            viewport={"width": width, "height": height}
        )
        page = await context.new_page()

        # DOMContentLoaded まで最大 10 秒だけ待つ（networkidle より速い）
        try:
            await page.goto(url, wait_until="domcontentloaded", timeout=10_000)
        except PlaywrightTimeoutError:
            print("DOMContentLoaded timeout (10s), 先に進みます…")

        # ここで「必ず」5秒待機
        await page.wait_for_timeout(5_000)

        # ビューポートに映っている範囲だけキャプチャ
        await page.screenshot(path=output_path, full_page=False)
        print(f"Saved viewport screenshot to {output_path}")

        await browser.close()

# Jupyter ならトップレベル await で実行
await capture_after_5s("https://example.com", "screenshot.png", 1280, 720)
```
