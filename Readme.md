config
```bash
#tftp
sudo firewall-cmd --zone=internal --add-forward-port=port=69:proto=udp:toport=8069

sudo firewall-cmd --add-service={http,tftp,nfs} --zone=internal
sudo firewall-cmd --runtime-to-permanent
```


# [DHCPサーバー](dhcpd/Readme.md)
- DHCPサーバーの構築を行う。  
- 同一LAN内にDHCPサーバーが存在しないことを確認して実行する必要がある。  
- ホストと同様のネットワークが必須であるため、コンテナを`--driver macvlan`オプションを用いて実行するか、接続するネットワークを作成する際に`--net host` オプションを用いる。

## --build-args
|引数名|値|
|:-:|:-:|
|CONFIG_FILE|dhcpサーバー用の設定ファイル名|


# [WEBサーバー](nginx/Readme.md)
- WEBサーバーの構築を行う
- PXE用であればHTTP通信のみで足りるため、443ポートは開放しない

## --build-args
|引数名|値|
|:-:|:-:|
|PAGE_FILE|公開するWEBページ|

TFTP
```
podman build -t tftp_internal:1.0 -f Dockerfile
podman run --pod PXEpod -d --name tftp_internal tftp_internal:1.0
```

Systemd setting
```bash
sudo podman generate systemd --new --name --files DHCPpod
sudo cp *.service /etc/systemd/system/
```