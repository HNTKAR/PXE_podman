FROM rockylinux:9.0

ARG CONFIG_FILE

RUN dnf -y update && dnf -y install dhcp-server cronie
# RUN dnf -y install rsyslog procps
# RUN sed -i -e "/imjournal/ s/^.*$//g" -e "/SysSock/ s/off/on/g" /etc/rsyslog.conf



RUN touch /etc/dhcp/dhcpd-user.cfg
COPY ["dhcpd-main.cfg","/etc/dhcp/"]
COPY ["${CONFIG_FILE}","/etc/dhcp/dhcpd-user.cfg"]
COPY ["dhcpd/run.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]