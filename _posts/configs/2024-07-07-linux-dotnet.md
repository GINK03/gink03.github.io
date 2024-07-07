---
layout: post
title: "linux dotnet"
date: 2024-07-07
excerpt: "linux dotnetの使い方"
tags: ["dotnet", "linux"]
config: true
comments: false
sort_key: "2024-07-07"
update_dates: ["2024-07-07"]
---

# linux dotnetの使い方

## インストール

**ubuntu**
```console
$ sudo apt-get update
$ sudo apt-get install -y dotnet-sdk-8.0
$ export PATH=$PATH:/usr/share/dotnet/
```

## 使用例

**新規プロジェクト作成**
```console
$ dotnet new console -o MyNewApp
```

**パッケージの追加(NuGet)**
```console
$ dotnet add package Newtonsoft.Json
```

**ビルド**
```console
$ dotnet build
```

**実行**
```console
$ dotnet run
```

## コード

```csharp
using System;
using Newtonsoft.Json;


class Program
{
    static void Main(string[] args)
    {
        Console.Write("Enter your name: ");
        string? name = Console.ReadLine();
        if (string.IsNullOrWhiteSpace(name))
        {
            Console.WriteLine("You must enter a name.");
        }
        else
        {
            Console.WriteLine($"Hello, {name}!");
        }

        var person = new { Name = name, Age = 25 };
        string json = JsonConvert.SerializeObject(person);
        Console.WriteLine(json);

        var deserializedPerson = JsonConvert.DeserializeObject(json);
        Console.WriteLine(deserializedPerson);
    }
}
```

## 参考
 - [Windows、Linux、および macOS に .NET をインストールする - Microsoft Docs](https://learn.microsoft.com/ja-jp/dotnet/core/install/)
