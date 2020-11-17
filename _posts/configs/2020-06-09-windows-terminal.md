---
layout: post
title: "windows-terminal"
date: 2020-06-09
excerpt: "windows-terminal"
tags: [windows-terminal]
config: true
comments: false
---

# windows-terminal

windowsで使う際のわりとまともに使える.  

[YouTubeに投稿してみたときのプレゼン資料](https://docs.google.com/presentation/d/1gipc9VgBmv98gunpZw16e0MQ_o7dfLkizO7zvFvbBE8/edit?usp=sharing)  

## install
```console
> choco install windows-terminal
```
or  
`Microsoft Store`  
or  
`Official github release`  

## 謎のクラッシュ時の対応
windows-terminalをMicrosoft Storeから最新版に更新する  

## github
`https://github.com/microsoft/terminal`

## config

configファイルがあるpathはwindowsにランダムで作られるdigest値を持ったパスになり、以下のようなパスになる  

 - e.g. `cd .\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\`  

digest値のパスはユーザやWindowsのUUID的なもので変わるため、環境により適切に再設定する必要がある  

keybindを変更することが可能で、タブ間の切り替えやkeybindのオーバーライドを無視させるのに以下のような設定で行える  

[theme](https://docs.microsoft.com/en-us/windows/terminal/customize-settings/color-schemes)も自由に設定することができ、以下のjsonの例では、"One Half Dark"というテーマを適応している  

```json
{
    "$schema": "https://aka.ms/terminal-profiles-schema",
    "copyOnSelect": false,
    "copyFormatting": false,
    "profiles":
    {
        "defaults":
        {
			// ここは必須
			"fontFace" : "SF Mono",
			"fontSize" : 13, 
			"colorScheme": "One Half Dark"
        },
        "list":
        [
		  ...
        ]
    },

    "schemes": [],
    "keybindings":
    [
	  // ここは必須
      { "command": {"action": "copy", "singleLine": false }, "keys": "ctrl+c" },
      { "command": "paste", "keys": "ctrl+v" },
      { "command": "find", "keys": "ctrl+shift+f" },
      { "command": { "action": "splitPane", "split": "auto", "splitMode": "duplicate" }, "keys": "alt+shift+d" },
	  { "command": "unbound", "keys": [ "ctrl+shift+down" ] },
	  { "command": "unbound", "keys": [ "ctrl+shift+left" ] },
	  { "command": "unbound", "keys": [ "ctrlshift+right" ] },
	  { "command": "unbound", "keys": [ "ctrl+shift+up" ] }, 
	  { "command": "newTab", "keys": [ "ctrl+t" ] },
	  { "command": "nextTab", "keys": [ "ctrl+]" ] }, 
	  { "command": "prevTab", "keys": [ "ctrl+[" ] } 
    ]
}
```
