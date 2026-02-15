---
layout: post
title: "Python AST"
date: 2026-02-15
excerpt: "Python AST"
project: false
config: true
tag: ["python", "ast"]
comments: false
sort_key: "2026-02-15"
update_dates: ["2026-02-15"]
---

# Python AST

## 概要
 - Pythonソースコードを解析して 抽象構文木（AST）として扱うための標準ライブラリ
 - 解析だけでなく 静的解析や自動変換（リファクタリング補助）にも使える
 - `ast.literal_eval` は `eval` の代替というより Pythonリテラルを安全にパースする用途で使うことが多い
 - CloudWatch Logs や GCP のログから リテラル文字列をそのまま取り出して オブジェクト化したい場面で使うことが多い

## ast.literal_eval

```python
import ast
data_str = "{'a': 1, 'b': 2}" # CloudWatch Logsからパースしたリテラル
data_dict = ast.literal_eval(data_str) # 安全に辞書型へ変換
assert data_dict == {"a": 1, "b": 2}
```

## ast.parse

```python
import ast

code = "x = 1 + 2"
# ソースコードをASTに変換
tree = ast.parse(code)

# 構造をダンプ（可視化）して確認
print(ast.dump(tree, indent=4))
"""
Module(
    body=[
        Assign(
            targets=[
                Name(id='x', ctx=Store())],
            value=BinOp(
                left=Constant(value=1),
                op=Add(),
                right=Constant(value=2)))],
    type_ignores=[])
"""
```

## 制限付きコード実行

 - ASTによるサンドボックスは難しく ここはデモ用の簡易例
 - 実運用で安全性が必要なら 専用のサンドボックスや別プロセス隔離を検討する

```python
import ast

def safe_execute(code_str):
    # 1. パースして抽象構文木(AST)を作る
    tree = ast.parse(code_str)

    # 2. ホワイトリスト方式でノードをチェック
    # 許可するノードの種類: 
    # Module(全体), Assign(代入), Name(変数名), Store/Load(読み書き), 
    # BinOp(二項演算), Add(足し算), Constant(定数/数値)
    allowed_nodes = {
        ast.Module, ast.Assign, ast.Name, ast.Store, 
        ast.Load, ast.BinOp, ast.Add, ast.Constant, ast.Expr
    }

    for node in ast.walk(tree):
        if type(node) not in allowed_nodes:
            raise ValueError(f"安全ではない操作が含まれています: {type(node).__name__}")

    # 3. チェックを通過した場合のみコンパイルして実行
    executable_code = compile(tree, filename="<safe_ast>", mode="exec")
    namespace = {}
    exec(executable_code, {"__builtins__": {}}, namespace) # builtinsを空にしてさらに制限
    
    return namespace

try:
    result = safe_execute("x = 1 + 2")
    print(f"成功: {result}")

    # 危険な例（関数呼び出しが含まれるのでエラーになる）
    safe_execute("import os; os.system('ls')")
except ValueError as e:
    print(f"ブロックされました: {e}")
```
