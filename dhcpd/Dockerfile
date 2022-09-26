FROM rockylinux:9.0

ARG CONFIG_FILE

RUN dnf -y update && dnf -y install dhcp-server cronie
# RUN dnf -y install rsyslog procps
# RUN sed -i -e "/imjournal/ s/^.*$//g" -e "/SysSock/ s/off/on/g" /etc/rsyslog.conf

RUN  echo -e \
"authoritative;\n"\
"include \"/etc/dhcp/dhcpd-user.cfg\";\n"\
> /etc/dhcp/dhcpd-main.cfg

RUN touch /etc/dhcp/dhcpd-user.cfg

COPY ["${CONFIG_FILE}","/etc/dhcp/dhcpd-user.cfg"]
COPY ["dhcpd/run.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]