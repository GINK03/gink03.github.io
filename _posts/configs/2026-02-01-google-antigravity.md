---
layout: post
title: "Google Antigravity"
date: 2026-02-01
excerpt: "GoogleがリリースしたAIエージェント型IDE「Antigravity」について"
config: true
tag: ["google", "ai", "ide", "agent", "gemini", "cli", "agy"]
comments: false
sort_key: "2026-02-01"
update_dates: ["2026-02-01", "2026-06-26"]
---

# Google Antigravity

## 概要
 - 2025年11月にGoogleがリリースした、**AIエージェント駆動型**の統合開発環境 (IDE)
 - 従来の「人間がコードを書く」スタイルから、「AIエージェントにタスクを指示して実装させる」**Agent-First Development** へのシフトを掲げている
 - VS CodeベースのUI

## 特徴

### Gemini 3 Pro 搭載
 - バックエンドには、コーディングと推論に最適化された最新モデル **Gemini 3 Pro** を採用
 - 大規模なコンテキスト理解と、複数ステップにわたる計画立案（Multi-step Planning）が可能

### Agent Manager と Multi-agent System
 - 開発者は「認証機能を実装して」といったゴールを提示する
 - 複数の専門エージェント（コーディング担当、テスト担当、リファクタリング担当など）が協調してタスクを遂行する
 - エージェントは自律的に計画、コード生成、実行、修正のループを回す

### Built-in Browser & Validation
 - IDE内にブラウザが内蔵されており、Webアプリの動作確認までエージェントが自動で行う
 - ブラウザ操作用のサブエージェントがChromeを立ち上げ、UIのテストやデバッグを実行する

### Antigravity Skills
 - エージェントに特定のドメイン知識やワークフローを追加するための仕組み
 - サーバーレスかつファイルベースの定義で、プロジェクト固有のルールやツールの使い方を学習させることができる

## CLI (`agy`)
 - Antigravity には、IDE と同じエージェント能力をターミナルに持ち込む Antigravity CLI が用意されている
 - 実体のコマンド名は `antigravity` ではなく `agy`（Go製のシングルバイナリ）
 - 2026年6月18日に無償提供を終了した Gemini CLI の後継として位置づけられており、マルチエージェント・スラッシュコマンド・サブエージェント等を引き継いでいる
 - キーボード中心の操作や、リモート SSH セッションでの利用に最適化されている

### インストール
 - 公式のインストールスクリプトで CLI を導入できる
 - インストール先は `~/.local/bin/` で、バイナリ名は `agy`、PATH に無い場合は警告が出るのでシェルの profile に追加する

```bash
curl -fsSL https://antigravity.google/cli/install.sh | bash
```

 - インストール後、バージョン確認

```bash
agy --version
```

### OAuth 認証
 - 初回起動時に Google Sign-In (OAuth) のフローが自動的に開始される
 - ブラウザが自動で立ち上がり、Google アカウントで認可するとトークンが OS のキーリングに保存される
 - 2回目以降はキーリングのトークンで自動認証され、ブラウザは開かない
 - SSH / ヘッドレス環境ではブラウザを起動できないため、認可用 URL が表示される、手元のブラウザで開いてサインインし、表示されたコードを端末に貼り戻す
 - ログアウト（保存済みトークンの破棄）は TUI 内のスラッシュコマンド `/logout` で行う

```bash
# 初回起動でログインフローが始まる
agy
```

### statusline の表示
 - statusline はカスタマイズ可能で、`settings.json` にスクリプトを指定して表示する
 - 設定ファイルは `~/.gemini/antigravity-cli/settings.json`

```json
{
  "statusLine": {
    "type": "",
    "command": "~/.gemini/antigravity-cli/statusline.sh",
    "enabled": true
  }
}
```

 - statusline には、エージェントの状態（Ready / Thinking / Working / Tool Use）、モデル名、作業ディレクトリ、Git ブランチ、コンテキストウィンドウの使用量、クォータ残量などをリアルタイムに表示できる
 - 端末幅に応じて 1 行 / 2 行のレイアウトに自動で切り替わる
 - TUI 内では `/statusline` スラッシュコマンドで statusline の管理ができる

### その他の便利なコマンド・操作
 - 非対話モード（スクリプト用）: `agy -p "プロンプト"`
 - モデル指定: `agy --model "model_name"` / 利用可能モデル一覧: `agy models`
 - 全自動（YOLO）モード: `agy --dangerously-skip-permissions`（確認なしで実行されるため注意）
 - アップデート: `agy update` / 変更履歴: `agy changelog`
 - Gemini CLI の拡張を移行: `agy plugin import gemini`
 - TUI 内: `/config`（設定）, `/goal`（計画承認なしで最後まで実行）, `/grill-me`（事前に確認質問させる）, `!` キーで Shell モードへトグル

## 使ってみた感想
 - 保守的に使用するならば、cursorとほぼ同じ使い勝手
   - 選択して `CMD + i` で選択範囲のAI編集が可能

## 参考
 - [Google Antigravity - Official Site](https://antigravity.google/)
 - [Introducing Google Antigravity: The Agent-First IDE](https://blog.google/technology/developers/antigravity-launch)
 - [Antigravity CLI Documentation](https://antigravity.google/docs/cli-using)
 - [google-antigravity/antigravity-cli (GitHub)](https://github.com/google-antigravity/antigravity-cli)
 - [Hands-on with Antigravity CLI - Google Codelabs](https://codelabs.developers.google.com/antigravity-cli-hands-on)
