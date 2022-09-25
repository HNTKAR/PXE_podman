config
```bash
#tftp
sudo firewall-cmd --zone=internal --add-forward-port=port=69:proto=udp:toport=8069
#http
sudo firewall-cmd --zone=internal --add-forward-port=port=80:proto=tcp:toport=8080 

sudo firewall-cmd --add-service={http,tftp,nfs} --zone=internal
sudo firewall-cmd --runtime-to-permanent
```

ALL
```bash
hostIP=192.168.*.*
sudo podman pod create --network bri --name DHCPpod
podman pod create --replace -n PXEpod -p $hostIP:8080:80 -p $hostIP:8069:69/udp -p $hostIP:2049:2049/udp --net slirp4netns:enable_ipv6=false,port_handler=slirp4netns
```

DHCPD
```bash
HostNetwork=xxx.xxx.xxx.xxx/x
IP_Range=yyy.yyy.yyy.yyy/y
ConfigFile=PrivateSetting/HOME/config/dhcp-user.cfg
sudo podman network create --driver macvlan --subnet $HostNetwork --opt parent=eth1 --ip-range $IP_Range LOCALMac
sudo podman build --tag dhcp:1.0 --file Dockerfile --build-arg CONFIG_FILE=$ConfigFile
sudo podman run --detach --replace --cap-drop ALL --cap-add CAP_DAC_OVERRIDE,CAP_NET_BIND_SERVICE,CAP_NET_RAW --pod DHCPpod --name dhcp_internal dhcp_Internal:1.0
```

NGINX
```
podman build -t nginx_internal:1.0 -f Dockerfile
podman run --pod DHCPpod -d --name nginx_internal nginx_internal:1.0
```

TFTP
```
podman build -t tftp_internal:1.0 -f Dockerfile
podman run --pod PXEpod -d --name tftp_internal tftp_internal:1.0
```