# はじめに
環境は以下の状態を想定する
|名称|値|
|:-:|:-:|
|ポッド名|pxe_pod|
|コンテナ名|pxe_web_container|
|イメージ名:バージョン|pxe_web:1.0|
|ホストのIPアドレス|192.168.1.6|
|ホストにバインドするポート|8080|
|外部からアクセスするポート|80|
|サーバーに配置するファイル|boot.ks|

```bash
# ファイアウォールの設定
sudo firewall-cmd --add-forward-port=port=80:proto=tcp:toport=8080 
sudo firewall-cmd --add-service=http
sudo firewall-cmd --runtime-to-permanent

cd PXE_podman
#ポッドの作成(ほかのコンテナとも共有)
podman pod create --replace --name pxe_pod -p 192.168.1.6:8080:80 -p 192.168.1.6:8069:69/udp -p 192.168.1.6:2049:2049/udp --net slirp4netns:enable_ipv6=false,port_handler=slirp4netns
# イメージのビルド
podman build --tag pxe_web:1.0 --file nginx/Dockerfile --build-arg PAGE_FILE=boot.ks .
# コンテナの実行
podman run --detach --replace --pod pxe_pod --name pxe_web_container pxe_web:1.0
```