---
layout: post
title: "karabiner elements"
date: 2021-02-11
excerpt: "karabiner elementsの概要と使い方"
tags: ["karabiner", "osx", "karabiner-elements"]
config: true
comments: false
sort_key: "2022-04-24"
update_dates: ["2022-04-24","2022-02-16","2022-02-06","2022-02-04","2022-02-01","2022-01-19","2021-09-07","2021-02-24","2021-02-17","2021-02-16","2021-02-11"]
---

# karabiner elementの概要と使い方

## 概要
 - macosxのシステムのキーボードの動きに対してフックを掛けて任意のキーを別の任意のキーに変換する、任意のキーショートカットを任意のシェルスクリプトに割り当てることができるソフトウェア
   - ショートカットにshell script、apple scriptを割り当てる方法として他には[/raycast/](/raycast/)を使用する方法がある

## インストール

**ダウンロード**  
 - [github releases](https://github.com/pqrs-org/Karabiner-Elements/releases)
 - インストール後は権限の許可と再起動が必要
   - 本当に有効になっているかの確認
     - 適当なキーを別なキーに変換して変換できているか確認する

**brew**  
```console
$ brew install karabiner-elements
```

## アンインストール

**command**  
```console
$ bash '/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/scripts/uninstall/deactivate_driver.sh'
$ sudo '/Library/Application Support/org.pqrs/Karabiner-Elements/uninstall.sh'
```

 - [参考](https://karabiner-elements.pqrs.org/docs/manual/operation/uninstall/)

## Simple modifications
 - 単にキーを置き換える
   - e.g. 
	 - `caps lock` -> `left_control`
	 - `caps lock`の置き換えはシステム設定からも行えるが、Complex modificationsを利用する際は置き換えたキーとして認識されないので、Simple modificationsも設定する必要がある

### おすすめのSimple modifications
 - 右のコマンドを`F20`に置き換える
   - `F20`で起動するランチャーなどを割り当てる


## Complex modifications
 - 任意のキーボードショートカットを与える
   - `~/.config/karabiner/karabiner.json`に設定ファイルが作成されるのでこれを編集して新規ショートカットの追加と編集を行う
   - `karabiner.json`の設定が読めない・間違っているなどとき、`karabiner-element`アプリのgui表示から設定が消える
   - バージョンの差があるのか、ネット上の設定をコピペしても動かないことがある
   - `simultaneous`というキーのコンビネーションはかなり挙動がシビアであり、結構入力が難しい
 - 現実的にjsonファイルを直接編集するのは難しいので[GokuRakuJoudo](https://github.com/yqrashawn/GokuRakuJoudo)という設定ジェネレータが便利
   - karabiner-elementsの設定プロファイルが`Default`という名前になっている必要がある
   - gokuの設定ファイルは`~/.config/karabiner.edn`にある必要がある
   - 様々なショートカットの作成例が乗っており参考にして作成する
   - `goku`コマンドでednファイルを解析して`karabiner.json`へ書き込む
  
### GokuRakuJoudoの設定例

```
{:devices       {;; define devices
                 ;; vendor_id and product_id can be found in Karabiner EventViewer gui
                 :hhkb [{:vendor_id 1452 :product_id 638}]
                 :keychron [{:vendor_id 1452 :product_id 591}]}

 :templates     {:open "open \"%s\""}
 :layers        {}
 :simlayers     {;; make w key a simlayer key
                 ;; layers works too, but only recommended for none typing keys
                 ;; like . , tab
                 ;; or keys like z, which used less often
                 :launch-mode {:key :right_option}}
 :main          [{:des   "change caps_lock to left_control"
                  :rules [[:caps_lock :left_control]]}
                 ;; keychronなどは右ctrlがあり右optionがないので割り当てる
                 {:des   "keychron/change right_control to right_option"
                  :rules [:keychron
                              [:fn :right_option]
                              [:escape :grave_accent_and_tilde]
                              [:right_control :right_option]]}
                 ;; f11で日本語かな, f12で日本語英数
                 {:des   "f11 to 日本語かな"
                  :rules [[:f11 :japanese_kana]]}
                 {:des   "f12 to 日本語英数"
                  :rules [[:f12 :japanese_eisuu]]}
                 ;; ##で装飾すると単体で押した時の動作を定義できる
                 {:des   "change right_command to f20"
                  :rules [[:##right_command :right_command nil {:alone  :f20}]]}
                 {:des   "change right_shift to f19"
                  :rules [[:##right_shift :right_shift nil {:alone  :f19}]]}
                 {:des   "right_option + .(period) to 日本語英数"
                  :rules [[[:right_option :period] :japanese_eisuu]]}
                 {:des   "right_option + ,(comma) to 日本語かな"
                  :rules [[[:right_option :comma] :japanese_kana]]}
                 {:des   "right_option + '(quote) to google chrome"
                  :rules [[[:right_option :quote] [:open "/Applications/Google Chrome.app"]]]}
                 {:des   "right_option + ;(semicolon) to iterm"
                  :rules [[[:right_option :semicolon] [:open "/Applications/iTerm.app"]]]}
                 {:des   "launch mode"
                  :rules [:launch-mode
                            ;; launch-mode + commaでかな入力に
                            [:comma [:japanese_kana]]
                            ;; launch-mode + peridで英数入力に
                            [:period [:japanese_eisuu]]
                            ;; 左側にfnが無いキーがあることがあるのでpage_up, page_downをoption + arrowで代替する
                            ;; launch-mode + up_arrowで page_upに
                            [:up_arrow [:page_up]]
                            ;; launch-mode + down_arrowで page_downに
                            [:down_arrow [:page_down]]
                            [:period [:japanese_eisuu]]
                            [:semicolon [:open "/Applications/iTerm.app"]]
                            [:quote [:open "/Applications/Google Chrome.app"]]]
                 }]
}
```

## インターネットのユーザが作成したmodifications
 - [link](https://ke-complex-modifications.pqrs.org/)
 - Microsoft RDPでコマンドをctrlにアプリが起動中のときのみ置き換える設定などがあり、便利である

## 尊師スタイルの設定
 - MacBookの上に外部キーボードを乗せて使うことを尊師スタイルと呼ぶ
 - `settings` -> `devices` -> `Disable the built-in keyboard while device is connected`を有効にする

## apple script(osascript)について
 - MacOSXの挙動を制御しているのは`apple script`なので特定のアプリになにかメッセージを与えるときには、`apple script`を実行する`shell script`を記述すれば良い  
 - 作成した`apple script`は[gist](https://gist.github.com/GINK03/7d646e1da20af7e51b30759f1b46d441)でホストしている

## トラブルシューティング

### karabiner event viewerが正常にキーを認識しない
 - 正常に動作した例
   1. `karabiner-elements`をアンイストール
   2. 再起動
   3. `karabiner-elements`を再インストール
   4. 再起動

### アプリの実行権限のパーミッションが消える
 - 原因
   - macosがクラッシュして強制再起動したときにkarabinerの実行権限が消失し再設定もできなくなる
 - 対応
   - karabinerのドライバーをアンインストールし、macを再起動、再インストールで解決した
