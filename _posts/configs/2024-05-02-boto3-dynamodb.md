---
layout: post
title: "boto3 dynamodb"
date: 2024-05-02
excerpt: "boto3 dynamodbの使い方"
project: false
config: true
tag: ["aws", "aws dynamodb", "dynamodb", "boto3"]
comments: false
sort_key: "2024-05-02"
update_dates: ["2024-05-02"]
---

# boto3 dynamodbの使い方

## 使用例

**テーブル作成**
```python
import boto3

def create_table():
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.create_table(
        TableName='Users',
        KeySchema=[
            {'AttributeName': 'user_id', 'KeyType': 'HASH'}  # Partition key
        ],
        AttributeDefinitions=[
            {'AttributeName': 'user_id', 'AttributeType': 'S'}
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 10,
            'WriteCapacityUnits': 10
        }
    )
    return table
```

**アイテムの挿入**
```python
def put_item(user_id, name, age):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('Users')
    response = table.put_item(
        Item={
            'user_id': user_id,
            'name': name,
            'age': age
        }
    )
    return response
```

**アイテムの取得**
```python
def get_item(user_id):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('Users')
    response = table.get_item(Key={'user_id': user_id})
    return response.get('Item')
```

**アイテムの更新**
```python
def update_item(user_id, name, age):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('Users')
    response = table.update_item(
        Key={'user_id': user_id},
        UpdateExpression='SET name = :val1, age = :val2',
        ExpressionAttributeValues={
            ':val1': name,
            ':val2': age
        },
        ReturnValues="UPDATED_NEW"
    )
    return response
```

**アイテムの削除**
```python
def delete_item(user_id):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('Users')
    response = table.delete_item(Key={'user_id': user_id})
    return response
```

**条件付きクエリ**
```python
def query_items(age):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('Users')
    response = table.query(
        KeyConditionExpression=Key('age').gt(age)
    )
    return response['Items']
```

**スキャン操作**
```python
def scan_table():
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('Users')
    response = table.scan()
    return response['Items']
```
