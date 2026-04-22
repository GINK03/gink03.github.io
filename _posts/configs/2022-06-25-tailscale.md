---
layout: post
title: "tailscale"
date: 2022-06-25
excerpt: "tailscaleの使い方"
tag: ["tailscale", "vpn", "wireguard"]
config: true
comments: false
sort_key: "2022-06-25"
update_dates: ["2022-06-25", "2026-04-17"]
---

# tailscaleの使い方

## 概要
 - hamachiのようなP2P VPN
   - 一部GUIがシェアウェアである点もhamachiと似ている
 - wireguardをバックエンドに使用しており、認証まわりを管理してくれる
   - wireguardは多少設定が面倒であるが、tailscaleを用いるとGoogle AccountやMicrosoft Accountでログインするだけで利用できる
 - UDP NAT traversalをサポートしており、NATの内側のコンピュータでもVPNネットワークに参加できる
 - 一定のコンピュータ数(20)までは無料なので、個人で利用するには十分そう
 - ある程度のオーバーヘッドがあり、速度が半分程度になる
 - コントロールプレーンという管理サーバが必要で、無料プランではここが制約となる
   - 半年に一度認証が解除されるため、いざというときに使えないのが痛い

## 仕組みと用語の整理
 - 認証・鍵管理
   - デフォルトでは一定期間でキーが期限切れになるため、無効化するにはWeb UIから`disable key expiry`を選択する
 - デバイス/アドレス管理
   - 登録しているコンピュータのIPアドレスは[Machines](https://login.tailscale.com/admin/machines)から確認できる
 - directモードとrelayモード
   - relayモードとdirectモードがあり、directモードはとても速いが`41641/udp`の開放が必要になる
   - 手動でポートを変更したい場合は`/etc/default/tailscaled`を編集すれば良い
   - 同じサブネットに複数のtailscaleのノードがあったとしてもポートを自動調整するので原則として変更する必要はない
   - directモードを確立できない場合、世界中に配置されたDERPと呼ばれる公開サーバをリレーとしてフォールバックする
     - `tailscale status`で接続状況を確認できる（`relay "tok"`であれば東京のリレーサーバ経由）
 - exit node
   - exit nodeを指定・利用することができる
   - VPNトンネリングを使うイメージで、すべてのトラフィックをexit node経由にできる
 - Override DNS
   - tailscale有効時 | exit node利用時 に任意のnameserverを指定することができる
     - `Admin Console` -> `DNS` -> `nameservers`にDNSを設定 + `Override local DNS`を有効にする
 - 仮想インターフェイス
   - Linux: `tailscale0`
   - macOS: `utunX`
 - セルフホストのコントロールプレーン
   - [headscale](https://github.com/juanfont/headscale)というコントロールプレーンをセルフホストにするOSSもある

## ユースケース
 - ファイアウォールの内部に構築したセキュアな環境にアクセスする
   - ssh
     - グローバルIPの設定がいらない
   - jupyter
     - 踏み台の設定が不要で楽

## セットアップ（インストール）

**linux**
```console
$ curl -fsSL https://tailscale.com/install.sh | sh
$ sudo tailscale up
```

**macOS**
 - `App Store`から`tailscale`を検索してインストール
 - App Store版ではCLIは含まれない

**macOSでビルドしてインストール/アップデート**
```console
$ go install tailscale.com/cmd/tailscale{,d}@main
$ sudo $HOME/.go/bin/tailscaled install-system-daemon # launchdに登録
```

## よく使うコマンド
 - 接続デバイス一覧と接続形式の確認

```console
$ tailscale status
```
 - 接続可能なデバイスの一覧を表示できる
 - メニューバーやタスクトレイから確認するより早い
 - 通信方式の確認
   - `relay <tok>`のような表示のときrelayサーバ経由でのアクセス
   - `direct 211.15.239.222:15968`のような表示のときdirectアクセス

 - ネゴシエーション込みのping（direct誘導にも有効）

```console
$ tailscale ping 100.108.132.113
pong from kichijouji (100.108.132.113) via DERP(tok) in 39ms
pong from kichijouji (100.108.132.113) via 211.15.239.222:41641 in 38ms
```

## exit nodeの設定/利用
 - tailscaleのルーティングするデバイスを指定してexit nodeにすることができる
   - exit nodeはルーターのような役割を持つ

**linuxをexit nodeとして設定**
```console
$ echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
$ echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
$ sudo sysctl -p /etc/sysctl.conf
$ sudo tailscale up --advertise-exit-node
```

**macOSでexit nodeを利用する**
 - tailscaleのアイコンをクリック
 - `Exit Node`を選択

**linuxでexit nodeを利用する**
```console
$ sudo tailscale up --exit-node=<exit-node-ip>
```

## ベンチマーク
 - relayサーバ経由だと、パフォーマンスが約54%に低下する

**直接接続した場合**
```console
$ netperf -H gimpeik.duckdns.org -t TCP_STREAM -v 2 -- -o mean_latency,throughput
MIGRATED TCP STREAM TEST from (null) (0.0.0.0) port 0 AF_INET to gimpeik.duckdns.org () port 0 AF_INET
Mean Latency Microseconds,Throughput
17474.43,58.68
```

**tailscaleのVPNを経由した場合**
```console
$ netperf -H 100.123.207.30 -t TCP_STREAM -v 2 -- -o mean_latency,throughput
MIGRATED TCP STREAM TEST from (null) (0.0.0.0) port 0 AF_INET to (null) () port 0 AF_INET
Mean Latency Microseconds,Throughput
33108.25,31.51
```

### wireguardとrelayサーバ経由のtailscaleの速度の違い
 - 2〜3倍程度の速度差がある

**wireguard**
```console
$ netperf -H 10.87.131.4 -t TCP_STREAM -- -o mean_latency,throughput
MIGRATED TCP STREAM TEST from (null) (0.0.0.0) port 0 AF_INET to (null) () port 0 AF_INET
Mean Latency Microseconds,Throughput
10961.86,94.87
```

**relayサーバ経由のtailscale**
```console
$ netperf -H 100.82.111.109 -t TCP_STREAM -- -o mean_latency,throughput
MIGRATED TCP STREAM TEST from (null) (0.0.0.0) port 0 AF_INET to (null) () port 0 AF_INET
Mean Latency Microseconds,Throughput
27856.18,37.48
```

## peer relay

 - tailnet内の任意のデバイスをリレーサーバとして指定できる機能（Tailscale 1.86以降）
 - directモードが確立できない場合、DERPサーバより先にpeer relayを試みる（DERP → peer relay → direct の優先順位ではなく、direct不可 → peer relay → DERPの順）
 - DERPサーバより低レイテンシ・高スループットで、クラウド環境ではエグレスコスト削減にもなる
 - iOS・Apple TV・Androidはpeer relayデバイスにはなれないが、利用側としては使用可能

**接続優先順位**
```
direct → peer relay → DERP
```

**step 1: peer relayデバイスの設定**

UDPポートを指定してpeer relayとして起動する

```console
$ tailscale set --relay-server-port=40000
```

ポートフォワードやロードバランサ経由の場合はstaticエンドポイントも指定する

```console
$ tailscale set --relay-server-port=40000 --relay-server-static-endpoints="203.0.113.1:40000"
```

**step 2: ACLのgrantポリシーを追加**

Admin Console → Access controls のJSONに `tailscale.com/cap/relay` ケイパビリティを持つgrantを追加する

```json
{
  "grants": [
    {
      "src": ["tag:clients"],
      "dst": ["tag:my-relay"],
      "app": {
        "tailscale.com/cap/relay": []
      }
    }
  ]
}
```

 - `src`: peer relay経由でアクセスされる側のデバイス（strictなNATやファイアウォール内のデバイス）
 - `dst`: peer relayとして機能させるデバイス
 - `*` を `src` に使うと全デバイスがpeer relayを経由しようとするため避ける

このACLポリシーはTerraformの `tailscale_acl` リソースで管理できる

```hcl
resource "tailscale_acl" "main" {
  acl = jsonencode({
    grants = [
      {
        src = ["tag:clients"]
        dst = ["tag:my-relay"]
        app = {
          "tailscale.com/cap/relay" = []
        }
      }
    ]
  })
}
```

**接続状況の確認**

```console
$ tailscale status | grep peer-relay
```

peer relay経由の接続は `direct` や `relay` ではなく `peer-relay` と表示される

**サーバサイドの設定確認**

```console
$ tailscale debug prefs
```

`RelayServerPort` にポート番号が設定されていればpeer relayが有効になっている

**無効化**

```console
$ tailscale set --relay-server-port=""
```

## セルフホスト（headscale）
 - 概要
   - tailscale互換のFOSS
   - tailscaleのコントロールプレーンのみをself-hostすることで完全無料で運用できる
   - インストールのハードルが高い
     - Dockerで管理するのが良い

## トラブルシューティング
 - direct connectionが利用できない
   - 原因
     - 接続クライアント側（ノートパソコン等）で公衆無線LANなどを利用していると、ルーター側の制限によりdirectモードを確立できないことがある

## 参考
 - [/r/Tailscale/](https://www.reddit.com/r/Tailscale/)
 - [Tailscaled on macOS](https://github.com/tailscale/tailscale/wiki/Tailscaled-on-macOS)
 - [How to re-authenticate in Linux](https://github.com/tailscale/tailscale/issues/367)
