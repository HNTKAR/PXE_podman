FROM rockylinux:9

RUN dnf -y update && dnf -y install tftp-server

RUN mkdir /data
COPY ["tftpd/run.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]