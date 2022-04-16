---
layout: post
title: "aws amazon translate"
date: 2022-04-16
excerpt: "aws amazon translate APIの使い方"
project: false
config: true
tag: ["aws", "nlp", "translate"]
comments: false
---

# aws amazon translate APIの使い方

## 参考
 - 特定言語から特定の言語に変換するAPI
 - 通常のawscliやbotoでのアクセスができる
   - csvファイルをアップロードすることで特殊な翻訳の例外を与えることができる

## awscliでの利用

```console
$ aws translate translate-text \
            --region ap-northeast-1 \
            --source-language-code "en" \
            --target-language-code "ja" \
            --text "hello, world"
{
    "TranslatedText": "こんにちは、ワールド",
    "SourceLanguageCode": "en",
    "TargetLanguageCode": "ja"
}
```

## boto3での利用

```python
import boto3

translate = boto3.client(service_name="translate", region_name="ap-northeast-1", use_ssl=True)

result = translate.translate_text(Text="Hello, World",
            SourceLanguageCode="en", TargetLanguageCode="ja")
print("TranslatedText: " + result.get("TranslatedText"))
print("SourceLanguageCode: " + result.get("SourceLanguageCode"))
print("TargetLanguageCode: " + result.get("TargetLanguageCode"))
```

**実行**  
```console
$ python3 aws-translate-example.py
TranslatedText: こんにちは、ワールド
SourceLanguageCode: en
TargetLanguageCode: ja
```

## 参考
 - [AWS SDK for Pythonを使用したテキストの翻訳（Boto）](https://docs.aws.amazon.com/translate/latest/dg/examples-python.html)
   - 翻訳の例外の設定等も含む
 - [Step 4: Getting started (AWS CLI)](https://docs.aws.amazon.com/translate/latest/dg/get-started-cli.html)
   - awscliドで実行する場合
