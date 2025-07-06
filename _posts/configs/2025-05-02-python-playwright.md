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
$ playwright install-deps # Linux の場合、必要な依存関係をインストール
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

### ローカルのHTMLをpngファイルに変換

```python
"""
ローカル HTML を PNG にレンダリングするスクリプト
-----------------------------------------------
使い方:
  python render_html_to_png.py input.html output.png
  # オプション
  python render_html_to_png.py input.html output.png --width 1920 --height 1080 --timeout 15000
"""

import argparse
from pathlib import Path
from playwright.sync_api import sync_playwright


def render(html_path: Path,
           png_path: Path,
           width: int = 1280,
           height: int = 720,
           timeout: int = 10_000) -> None:
    """
    Playwright で HTML を描画し PNG に保存する。

    :param html_path: 入力 HTML のパス
    :param png_path: 出力 PNG のパス
    :param width:  ビューポート幅
    :param height: ビューポート高さ
    :param timeout: 読み込み完了までのタイムアウト (ミリ秒)
    """
    html_path = html_path.resolve()
    png_path = png_path.resolve()

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        try:
            page = browser.new_page(viewport={"width": width, "height": height})
            page.goto(f"file://{html_path}")
            page.wait_for_load_state("networkidle", timeout=timeout)
            png_path.parent.mkdir(parents=True, exist_ok=True)
            page.screenshot(path=str(png_path), full_page=True)
            print(f" Saved: {png_path}")
        finally:
            browser.close()


def main() -> None:
    parser = argparse.ArgumentParser(description="Render local HTML to PNG via Playwright")
    parser.add_argument("input_html", type=Path, help="入力 HTML ファイルへのパス")
    parser.add_argument("output_png", type=Path, help="出力 PNG ファイルへのパス")
    parser.add_argument("--width", type=int, default=1280, help="ビューポート幅 (デフォルト: 1280)")
    parser.add_argument("--height", type=int, default=720, help="ビューポート高さ (デフォルト: 720)")
    parser.add_argument("--timeout", type=int, default=10_000, help="読み込みタイムアウト ms (デフォルト: 10000)")
    args = parser.parse_args()

    render(args.input_html, args.output_png, args.width, args.height, args.timeout)


if __name__ == "__main__":
    main()
```
