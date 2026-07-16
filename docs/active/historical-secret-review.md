# Git履歴内の資格情報候補を確認する

> **Status**: Active

## 状況
 - 2026-07-16の`gitleaks dir . --redact`では現在ツリーの検出は0件
 - `gitleaks git . --redact`では過去4189コミットから`generic-api-key`が10件検出された
 - `sort_key`、VS Code keybinding、記事内のコマンド例など明確な誤検知を含む
 - 2020年のLINE token例とWireGuard PrivateKey例は実値だった可能性を外部から判定できない

## 対応
 - 既存10件だけをcommit、path、rule、lineからなるfingerprintで`.gitleaksignore`へ登録
 - 現在ツリーと今後の別fingerprintは引き続き検査対象とする
 - 値そのものは文書やログへ記録しない

## 完了条件
 - LINE token例が実値なら発行元で失効済みと確認する
 - WireGuard PrivateKey例が実値なら対応する鍵を交換済みと確認する
 - 確認後に本書を`docs/archive/`へ移す
