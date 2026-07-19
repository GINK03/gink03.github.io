---
layout: post
title: "Claude Code"
date: 2025-07-05
excerpt: "Claude Code の使い方メモ"
config: true
tag: ["claude code"]
comments: false
sort_key: "2026-07-18"
update_dates: ["2026-07-18","2026-06-22","2025-07-05"]
---

## 概要
 - Codex CLI や Gemini CLI に近いエージェント型の CLI ツール
 - `CLAUDE.md` をプロジェクトのルートに置くと Claude Code が文脈を読み取りやすくなる
 - AWS Bedrock や GCP Model Garden で Claude のモデルをデプロイして利用できる

## インストール

**npm**

```console
$ npm install -g @anthropic-ai/claude-code
```

**bun**

```console
$ bun add -g @anthropic-ai/claude-code
$ bun pm -g trust @anthropic-ai/claude-code
```

## 実行

```console
$ claude
```

 - 選択肢で Esc で抜けられないときは Ctrl + Esc を試す

**自動許可**

```console
$ claude --dangerously-skip-permissions
```

 - 権限確認をスキップするため注意

## tmuxでClaude Codeのスクロール履歴を使う

### fullscreen rendererとtmux

 - fullscreen rendererは端末のalternate screenを使い、表示中の内容だけを描画する
 - 会話は端末の通常scrollbackへ流れないため、tmuxの`history-limit`を増やしても過去の会話をcopy-modeから参照できない
 - Claude Code内で`/tui`を実行すると、現在のrendererを確認できる

```text
/tui
```

### 現在の会話をtmuxへ書き出す

Claude Codeで`Ctrl+O`を押してtranscript modeへ入り、続けて`[`を押す

```text
Ctrl+O
[
```

会話全文が端末の通常scrollbackへ書き出された後、tmuxの標準prefixでは次の操作でcopy-modeへ入れる

```text
Ctrl-b [
```

### classic rendererへ戻す

tmuxのcopy-modeや端末の検索を常時使う場合は、Claude Code内でclassic rendererへ戻す

```text
/tui default
```

保存済み設定にかかわらずclassic rendererを使う場合は、Claude Codeを起動するシェルの設定へ次を追加する

```bash
export CLAUDE_CODE_DISABLE_ALTERNATE_SCREEN=1
```

設定後はシェル設定を再読み込みしてからClaude Codeを起動する

```console
$ source ~/.zshrc
```

 - Bashを使う場合は`~/.bashrc`へ追加し、`source ~/.bashrc`で再読み込みする
 - `claude attach`などのbackground sessionでは常にfullscreen rendererが使われ、この環境変数は適用されない

### fullscreen rendererをtmuxで使う

fullscreen rendererを維持し、マウスホイールで会話をスクロールする場合は`~/.tmux.conf`でmouse modeを有効にする

```config
set -g mouse on
```

```console
$ tmux source-file ~/.tmux.conf
```

 - `PgUp`と`PgDn`によるスクロールはmouse modeに関係なく利用できる
 - iTerm2のtmux integration modeである`tmux -CC`はfullscreen rendererと互換性がない
 - 通常のtmuxセッションではfullscreen rendererを利用できる
 - tmux自体の操作は[tmux記事](/tmux/)を参照

## ヘッドレス実行

```console
$ claude -p "ミッションを実行せよ" \
  --max-turns 100 --dangerously-skip-permissions --verbose
```

**ログをストリーミング**

```console
$ claude -p "ミッションを実行せよ" \
  --max-turns 100 \
  --dangerously-skip-permissions \
  --output-format=stream-json \
  --verbose
```

## 認証
 - 認証先として `console.anthropic.com` を選択できる

## トラブルシューティング

### `claude native binary not installed`
 - Bunでglobal installしたときにpostinstallが実行されず、ネイティブバイナリが入っていないと発生する
 - `bun pm -g trust @anthropic-ai/claude-code`でpostinstallを許可する

```text
Error: claude native binary not installed.

Either postinstall did not run (--ignore-scripts, some pnpm configs)
or the platform-native optional dependency was not downloaded
(--omit=optional).
```

## API 経由での利用

**環境変数**

```bash
export ANTHROPIC_API_KEY=sk-ant-*****
export ANTHROPIC_MODEL=sonnet # 例
```

## GCP Model Garden 経由での利用

 - Model Garden で使用したいモデルをデプロイ
 - 必要な環境変数を設定
 - 例では `claude-3-7-sonnet@20250219` を使用
 - `gcloud` コマンドで ADC を設定

**ADC の設定**

```bash
$ gcloud auth application-default login
```

**環境変数**

```bash
export CLAUDE_CODE_USE_VERTEX=1
export ANTHROPIC_VERTEX_PROJECT_ID=cosmic-bonfire-354108
export CLOUD_ML_REGION=us-east5
export ANTHROPIC_MODEL=claude-3-7-sonnet@20250219 # デプロイしたモデルを指定
```

**グローバル設定: `~/.claude/settings.json`**
```json
{
  "env": {
    "CLAUDE_CODE_USE_VERTEX": "1",
    "ANTHROPIC_VERTEX_PROJECT_ID": "cosmic-bonfire-354108",
    "CLOUD_ML_REGION": "us-east5",
    "ANTHROPIC_MODEL": "claude-sonnet-4-5@20250929"
  }
}
```

**ローカル設定: `.claude/settings.local.json`**

 - AWS Bedrock を GCP Model Garden でオーバーライドする例

```json
{
  "env": {
    "CLAUDE_CODE_USE_BEDROCK": "0",
    "CLAUDE_CODE_USE_VERTEX": "1",
    "ANTHROPIC_VERTEX_PROJECT_ID": "your-gcp-project-id",
    "CLOUD_ML_REGION": "us-east5",
    "ANTHROPIC_MODEL": "claude-3-7-sonnet@20250219"
  }
}
```

## 参考

 - [Fullscreen rendering - Claude Code Docs](https://code.claude.com/docs/en/fullscreen)
 - [Tmux scrollback broken after May 26 update](https://github.com/anthropics/claude-code/issues/62890)
