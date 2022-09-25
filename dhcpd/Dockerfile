FROM rockylinux:9.0

ARG CONFIG_FILE
ARG POD_NETWORK_ADDR=10.0.2.0
ARG POD_MASK_ADDR=255.255.255.0
ARG BROADCAST_ADDR=10.0.2.255
ARG DNS_ADDR=10.0.2.1
ARG GATEWAY_ADDR=10.0.2.1
ARG LEASE_TIME=3600

RUN dnf -y update && dnf -y install dhcp-server cronie
# RUN dnf -y install rsyslog procps
# RUN sed -i -e "/imjournal/ s/^.*$//g" -e "/SysSock/ s/off/on/g" /etc/rsyslog.conf
RUN  echo -e \
"authoritative;\n"\
"include \"/etc/dhcp/dhcpd-podman.cfg\";\n"\
"include \"/etc/dhcp/dhcpd-user.cfg\";\n"\
> /etc/dhcp/dhcpd-main.cfg

RUN echo -e \
"#subnet ${POD_NETWORK_ADDR} netmask ${POD_MASK_ADDR} {\n"\
"#DNS_ADDR option broadcast-address ${BROADCAST_ADDR};\n"\
"#option domain-name-servers ${DNS_ADDR};\n"\
"#option routers ${GATEWAY_ADDR};\n"\
"#default-lease-time ${LEASE_TIME};\n"\
"#}\n"\
> /etc/dhcp/dhcpd-podman.cfg

RUN touch /etc/dhcp/dhcpd-user.cfg

COPY ["${CONFIG_FILE}","/etc/dhcp/dhcpd-user.cfg"]
COPY ["dhcpd/run.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]