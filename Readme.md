# はじめに
以下に各コンテナの説明や環境の設定を記載

## 全体設定
|名称|値|備考|
|:-:|:-:|:-:|
|ポッド名|file|ポッド作成時に設定|

## mariadb container
データベース

|名称|値|備考|
|:-:|:-:|:-:|
|localtime|Asia/Tokyo|
|socket|`/sock/mysql.sock`|
|DB root password|password|`Dockerfile`にて設定|
|kea DB name|kea_db|`kea.sql`にて設定|
|kea DB user|kea_user|`kea.sql`にて設定|
|kea DB password|kea_password|`kea.sql`にて設定|

## kea container
dhcp
|名称|値|備考|
|:-:|:-:|:-:|
|localtime|Asia/Tokyo|
|`CONFIG_FILE`|-|`--build-arg`により設定|

コンテナ起動時、以下のように変数を設定することでwebサーバの設定を変更可能  
(デフォルトでは`192.168.1.0/24`用の設定が設定されているため、自身の環境用に併せて変更する)  
```bash
sudo podman build --build-arg CONFIG_FILE=$HOME/kea.conf --tag network-kea:$TagName --file kea/Dockerfile .
```

# 実行スクリプト

## 各種コンテナの起動
<!-- ブランチの切り替えにより、alpineをベースとしたイメージにも変更可能 -->
```bash
cd network_podman

# タグの名称を設定
TagName="main"

# 利用するNIC名を設定
NIC="eth0"

# 利用するIPアドレスを指定
NewIP="192.168.1.10"

# 所属ネットワークのサブネットアドレスを指定
SubnetAddr="192.178.1.1/24"

# ネットワークの作成
sudo podman network create --driver macvlan --subnet $SubnetAddr --opt parent=$NIC LocalLAN

# ボリュームの作成
sudo podman volume create network_mariadb_dir

# ポッドの作成
sudo podman pod create --replace --network LocalLAN --ip=$NewIP --name network

# mariadb
sudo podman build --tag network-mariadb:$TagName --file mariadb/Dockerfile .
sudo podman run --detach --replace --mount type=volume,source=network_mariadb_dir,destination=/var/lib/mysql --pod network --name network-mariadb network-mariadb:$TagName

# kea
sudo podman build --tag network-kea:$TagName --file kea/Dockerfile .
sudo podman run --detach --replace --privileged --volumes-from network-mariadb --pod network --name network-kea network-kea:$TagName
```

## 自動起動の設定
```sh
sudo podman generate systemd -f -n --new --restart-policy=on-failure network >tmp.service
cat tmp.service | \
xargs -I {} sudo cp {} -frp /etc/systemd/system/
sed -e "s/.*\///g" tmp.service | \
grep pod | \
xargs -n 1 sudo systemctl enable --now
```

## 自動起動解除
```sh
sed -e "s/.*\///g" tmp.service | \
grep pod | \
xargs -n 1 sudo systemctl disable --now
```