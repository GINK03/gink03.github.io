# 0005. 品質検証済みのJekyll成果物をGitHub Pagesへ配信する

> **Status**: Accepted（2026-07-16 決定）

## Context（背景）
 - 従来はcontent quality WorkflowとGitHub Pagesのlegacyビルドが同じpushで別々にJekyllを実行していた
 - legacyビルドはリポジトリの`Gemfile.lock`をそのまま使えず依存関係の警告が発生していた
 - 品質検証が成功したHTMLと実際に公開されるHTMLが別ビルドだった
 - `github-pages` gemはsafe modeでローカルJekyll pluginを無効化するため、記事画像の属性補完には明示的なビルド後処理が必要だった
 - 関連方針は [[0003-content-quality-and-topic-navigation]] と [[0004-related-post-ranking]] に従う

## Decision（決定）
 - `.github/workflows/content-quality.yml`でJekyllを1回だけビルドする
 - Jekyllビルド後にNokogiriで記事画像の読み込み属性を補完する
 - frontmatter、監査資料、関連記事データ、生成HTML、内部リンク、シークレットを検査する
 - 検査済みの`_site`を`actions/upload-pages-artifact`で保存する
 - contentとsecretsの両ジョブが成功した場合だけ`actions/deploy-pages`で公開する
 - GitHub ActionsはリリースタグではなくコミットSHAへ固定し、Dependabotで更新する
 - Workflow反映後にPagesの`build_type`を`workflow`へ切り替える
 - 外部リンクは不安定要因になるためpush時に失敗させず、週次Workflowで別に検査する

## 検討した代替案
 - legacyビルドを維持する案は二重ビルドと依存関係差異が残るため不採用
 - 検証とデプロイを別Workflowにする案は成果物と実行関係が分かれ追跡しにくいため不採用
 - 外部リンク検査をpush必須条件にする案は外部サイト障害で公開が止まるため不採用

## Consequences（影響）
 - ローカル、CI、公開環境が同じ`Gemfile.lock`とビルド後処理を使う
 - 検査に失敗した成果物は公開されない
 - legacy Pagesビルドが不要になり、同一pushのJekyll実行回数が減る
 - WorkflowまたはGitHub Actions障害時はデプロイできない
 - Pages設定の`build_type`切替が初回に一度必要になる

## 参考
 - CIとデプロイ: `.github/workflows/content-quality.yml`
 - 週次リンク検査: `.github/workflows/external-links.yml`
 - 画像属性のビルド後処理: `scripts/enhance_article_images.rb`
 - [GitHub PagesのカスタムWorkflow](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages)
