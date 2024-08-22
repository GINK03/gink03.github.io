---
layout: post
title: "aws redshift serverless"
date: 2024-08-22
excerpt: "aws redshift serverlessの概要と使い方"
project: false
config: true
tag: ["aws", "aws redshift serverless", "redshift serverless"]
comments: false
sort_key: "2024-08-22"
update_dates: ["2024-08-22"]
---

# aws redshift serverlessの概要と使い方

## 概要
 - AWSのredshift serverlessは、従量課金制のredshiftサービス
 - GCPのbigqueryやawsのathenaに似たサービス

## データパイプラインの例
 - 1. S3にログデータを保存
 - 2. AWS lambdaでデータをredshift serverlessにロード
 - 3. redshift serverlessでETL処理
 - 4. redshift serverlessで分析や可視化やBIツールでの分析

### 2. AWS lambdaでデータをredshift serverlessにロード

```python
import boto3
import psycopg2
import os
from urllib.parse import unquote_plus

def lambda_handler(event, context):
    # S3イベントからバケット名とファイル名を取得
    s3_bucket = event['Records'][0]['s3']['bucket']['name']
    s3_key = unquote_plus(event['Records'][0]['s3']['object']['key'])

    # Redshift接続情報
    redshift_endpoint = os.getenv('REDSHIFT_ENDPOINT')
    redshift_db = os.getenv('REDSHIFT_DB')
    redshift_user = os.getenv('REDSHIFT_USER')
    redshift_password = os.getenv('REDSHIFT_PASSWORD')

    conn = psycopg2.connect(
        host=redshift_endpoint,
        dbname=redshift_db,
        user=redshift_user,
        password=redshift_password
    )
    cursor = conn.cursor()

    # S3からRedshiftにデータを一時テーブルにロード
    copy_sql = f"""
    COPY raw_apache_logs(log_entry)
    FROM 's3://{s3_bucket}/{s3_key}'
    IAM_ROLE 'arn:aws:iam::123456789012:role/MyRedshiftRole'
    DELIMITER ' '
    IGNOREHEADER 0
    REMOVEQUOTES
    ;
    """
    cursor.execute(copy_sql)
    conn.commit()

    cursor.close()
    conn.close()

    return {
        'statusCode': 200,
        'body': f'Successfully loaded {s3_key} into Redshift'
    }
```

### 3. redshift serverlessでETL処理

```sql
-- 正規表現を使用してApacheログをパースし、加工されたデータを新しいテーブルに挿入
CREATE TABLE processed_apache_logs AS
SELECT
    REGEXP_SUBSTR(log_entry, '^\\S+') AS ip,  -- IPアドレス
    TO_TIMESTAMP(REGEXP_SUBSTR(log_entry, '\\[(.*?)\\]'), 'DD/Mon/YYYY:HH24:MI:SS') AS log_date,  -- 日時
    REGEXP_SUBSTR(log_entry, '"(\\w+)') AS method,  -- HTTPメソッド
    REGEXP_SUBSTR(log_entry, '"\\w+\\s(.*?)\\sHTTP') AS path,  -- リクエストされたパス
    REGEXP_SUBSTR(log_entry, 'HTTP/\\d\\.\\d') AS protocol,  -- プロトコル
    CAST(REGEXP_SUBSTR(log_entry, '\\s(\\d{3})\\s') AS INT) AS status,  -- ステータスコード
    CASE
        WHEN REGEXP_SUBSTR(log_entry, '\\s\\d{3}\\s(\\d+|-)') = '-' THEN 0
        ELSE CAST(REGEXP_SUBSTR(log_entry, '\\s\\d{3}\\s(\\d+|-)') AS INT)
    END AS size,  -- 応答サイズ
    REGEXP_SUBSTR(log_entry, '"(http[^"]*)') AS referrer,  -- リファラー
    REGEXP_SUBSTR(log_entry, '"[^"]+"$') AS user_agent  -- ユーザーエージェント
FROM
    raw_apache_logs;

-- 加工後に必要ならば、元の一時テーブルを削除
DROP TABLE raw_apache_logs;
```
