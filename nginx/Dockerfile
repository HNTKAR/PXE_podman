FROM rockylinux:9.0

ARG PAGE_FILE

RUN dnf -y update && dnf -y install nginx cronie 
# RUN dnf -y install rsyslog procps
# RUN sed -i -e "/imjournal/ s/^.*$//g" -e "/SysSock/ s/off/on/g" /etc/rsyslog.conf

RUN rm -f /var/log/nginx/*
RUN ln -s /dev/stderr /var/log/nginx/error.log
RUN ln -s /dev/stdout /var/log/nginx/access.log

COPY ["${PAGE_FILE}","/usr/share/nginx/html/"]
COPY ["nginx/run.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]
