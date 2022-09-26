# はじめに
環境は以下の状態を想定する。

|名称|値|
|:-:|:-:|
|ポッド名|dhcp_pod|
|コンテナ名|dhcp_container|
|イメージ名:バージョン|dhcp:1.0|
|ネットワークアドレス|192.168.1.0/24|
|コンテナのIPアドレス|192.168.1.10|
|バインドするNIC名|eth0|
|設定ファイル|config.cfg|
|podman内で作成するネットワーク名|LocalLAN|
|DNSサーバーのIPアドレス|192.168.1.2|
|ゲートウェイのアドレス|192.168.1.1|

dhcp-serverの実行に必要な権限は下記の通りである。
- CAP_DAC_OVERRIDE
- CAP_NET_BIND_SERVICE
- CAP_NET_RAW

# 実行スクリプト
```bash
cd PXE_podman
# 参加するネットワークを作成(macvlanを利用する場合)
sudo podman network create --driver macvlan --subnet 192.168.1.0/24 --opt parent=eth0 LocalLAN
# ポッドの作成
sudo podman pod create --network LocalLAN --ip=192.168.1.10 --name dhcp_pod
# イメージのビルド
sudo podman build --tag dhcp:1.0 --file dhcpd/Dockerfile --build-arg CONFIG_FILE=config.cfg .
# コンテナの実行
sudo podman run --detach --replace --cap-drop ALL --cap-add CAP_DAC_OVERRIDE,CAP_NET_BIND_SERVICE,CAP_NET_RAW --pod DHCPpod --name dhcp_container dhcp:1.0
```
# dhcpにおける設定ファイルの例
```
subnet 192.168.1.0 netmask 255.255.255.0 {
    DNS_ADDR option broadcast-address 192.168.1.255;
    option domain-name-servers 192.168.1.2;
    option routers 193.168.1.1;
    default-lease-time 300;
}
```