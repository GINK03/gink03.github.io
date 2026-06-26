
# プロジェクトの説明
 - このプロジェクトはブログのマークダウン管理します
 - エージェントの目的はブログの指定されたコンテンツの不備を修正することです

## 構造の説明
 - `_posts/<subdir>` 以下に個々のmarkdownコンテンツが配置されている
 - `<subdir>`はコンテンツの性質に応じて作成されている

## 基本的に守ってほしいこと
 - `git` 関連の操作（`git commit`, `pre-commit関連のチェック` 等) は必要ない
 - バレットリストと番号付きリストの一段目は先頭に空白を一つ入れる
   - 例 ` - item` ` 1. item`
 - フロントマターのtagsは揺れを起こしており、`tags`または`tag`のことがあるが原則`tag`を用いる(対象のマークダウンを除き積極的に修正はしない)
 - 句点（。）は使用しない
 - マークダウンの太字記法（`**text**`）は文中への埋め込みはNG。ただし、小セクションの見出し代わりに一行まるごと太字にする用法（例: `**エージェントの定義**` 単体で1行）はOK
 - ユーザへの通知は日本語を優先する
 - 記事内で他記事へリンクする場合、Jekyllのパーマリンクは `/<title>/` の形式になる（例: `[dbt記事](/dbt/)`）。`/subdir/YYYY/MM/DD/title/` のようなパスは使用しない
 - Windows特化の情報（PowerShell用コマンド、Windowsのパスやキーリング等）は原則記載しない
 - 見出しはSEOを意識して整合的にする
   - 記事タイトルはレイアウトが `<h1>` として出力するため、本文に `#`(h1) は書かない（本文は `##`(h2) から始める）
   - 見出しレベルは飛ばさない（`##` の下は `###`、`##`→`####` のような飛びはNG）。階層を1段ずつ深くする
 - SEO観点を意識する（構造化データJSON-LD・`lang`・sitemap・canonical等は `_includes/head.html` とレイアウトで対応済み。テンプレート変更時に壊さない。画像は表示サイズに見合うよう軽量化する）

## トンマナの踏襲
 - 記事を新規作成または大きく改稿する場合は、few-shotとして既存記事を3つ以上読む
 - 参照する記事は、対象記事と内容、カテゴリ、公開時期が近いものを優先する
 - 参照記事は見出し、文体、粒度、コード例、リンクの置き方を省略せずに確認し、既存ブログのトンマナを把握したうえで編集する
 - ただし、質問への応答のみが求められている場合はファイルを編集しない

## push後の確認
 - `git push` 後に `gh run list --limit 5` でGitHub Pagesのビルド状況を確認する

## docs/ 運用
 - `docs/draft/` — 非定型のメモ、一時アウトプット、会話から作った手順書、暫定ドラフト。後で root README や恒久文書へ昇格させる前提の置き場
 - `docs/todo/` — 未着手の構想・アイデア
 - `docs/active/` — 進行中・残課題あり
 - `docs/hold/` — 今すぐ着手しない保留項目。着手する段階で `docs/todo/` または `docs/active/` に切り出す
 - `docs/adr/` — アーキテクチャ/技術的な意思決定の記録（Architecture Decision Record）。`NNNN-タイトル.md` の連番で1決定1ファイル。背景（Context）・決定（Decision）・影響（Consequences）・ステータス（Proposed / Accepted / Superseded 等）を記載する
 - `docs/reference/` — 実装済みの設計パターン、運用方針、参照資料
 - `docs/archive/` — 完了済み・歴史的記録。新規に archive へ移す文書は、可能ならファイル先頭に `> **Status**: ✅ Completed / ❌ Abandoned / 🗄️ Archived` を記載する。既存文書は古い形式のものも残っていてよい

## SEO（2026-06-26 調査と対応の記録）
他エージェント向けの引き継ぎ。詳細な改善案は `docs/draft/seo-improvements.md` も参照

**わかったこと（診断）**
 - 本当のボトルネックは順位ではなく「インデックス未登録」。Search Console の URL Inspection で確認したところ、トップ `/` と一部の一覧ページ（`/configs/` `/kaggle/`）は index 済みだが、そこからリンクされた個別記事は `/git/` `/markdown/` `/sops/` `/dijkstra/` 等ことごとく "URL is unknown to Google"（5年前の記事すら未クロール）
 - 内部リンク自体は概ね健全（一覧ページは絶対URLで全記事にリンク済み、`/posts/` は1541記事をリンクするマスター一覧）。それでも記事が拾われない
 - 原因は典型的なクロールバジェット枯渇＝ドメイン権威の低さ（github.io・1700超の短い記事）。技術では解消できない領域

**対処したこと（テクニカル、実装済み）**
 - 構造化データ JSON-LD（BlogPosting、`dateModified` は `update_dates` 由来）を `_includes/head.html` に出力
 - 全レイアウトの `<html>` に `lang="ja"`
 - robots.txt に `Sitemap:` 行、`jekyll-sitemap` が `/sitemap.xml`(約1770URL) を生成
 - H1重複の解消＋見出しレベル正規化（本文h1を1745→1、レベル飛び0）。規約は「基本的に守ってほしいこと」参照
 - 画像LCP（ロゴ737K→41K、背景をWebP化451K→216K）
 - トップから `/posts/`(全記事一覧)・`/projects/`・`/bookmarks/`・`/tags/` への導線追加（`_layouts/home.html`）
 - Search Console に `gink03.github.io` をプロパティ登録済み（所有者: angeldust03@gmail.com）

**やるべきこと / 未了**
 - Search Console で `sitemap.xml` を送信（ユーザ対応中）。送信後、数日〜数週でインデックス状況を再確認する
 - トピッククラスタ化（関連記事の相互リンク自動付与）は未着手。内部で効くのでテクニカル施策として有力
 - 権威向上（被リンク・Zenn/Qiitaクロスポスト）は非テクニカルで保留。当面はテクニカルに対応できる範囲で進める方針

**インデックス状況の確認方法（エージェント向け）**
 - ADC（`gcloud auth application-default`、readonlyスコープ `auth/webmasters.readonly`）で Search Console API を叩ける。quota project は個人GCP `starry-lattice-256603`、`X-Goog-User-Project` ヘッダ必須
 - URL Inspection: `POST https://searchconsole.googleapis.com/v1/urlInspection/index:inspect`（body: `inspectionUrl`, `siteUrl`）で任意URLの index 状況を即時照会
 - sitemap送信や登録系は書き込みスコープ `auth/webmasters` が必要（readonlyでは403）
 - PageSpeed/Lighthouse は dots の `bin/seocheck <url>`（ADC利用・キー不要）でSEO/性能スコアを取得できる

## 遵守事項
 - `git restore .` を絶対行わない
 - 質問への応答のみが求められている場合、リポジトリ内のファイル（コードや記事）を編集しない
