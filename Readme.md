config
```bash
sudo firewall-cmd --add-service={http,dhcp,tftp,nfs} --zone=internal
#dhcp
sudo firewall-cmd --zone=internal --add-forward-port=port=67:proto=udp:toport=8067 
#tftp
sudo firewall-cmd --zone=internal --add-forward-port=port=69:proto=udp:toport=8069
#http
sudo firewall-cmd --zone=internal --add-forward-port=port=80:proto=tcp:toport=8080 
sudo firewall-cmd --runtime-to-permanent
```

ALL
```
hostIP=192.168.*.*
podman pod create --replace -n PXEpod -p $hostIP:8080:80 -p $hostIP:8069:69/udp -p $hostIP:8067:67/udp -p $hostIP:2049:2049/udp --net slirp4netns:enable_ipv6=false,port_handler=slirp4netns
```

DHCPD
```
podman build -t dhcp_internal:1.0 -f Dockerfile
podman run --pod PXEpod -d --name dhcp_internal dhcp_internal:1.0
```

NGINX
```
podman build -t nginx_internal:1.0 -f Dockerfile
podman run --pod PXEpod -d --name nginx_internal nginx_internal:1.0
```

TFTP
```
podman build -t tftp_internal:1.0 -f Dockerfile
podman run --pod PXEpod -d --name tftp_internal tftp_internal:1.0
```