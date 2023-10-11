FROM alpine:3.17

ARG CONFIG_FILE="kea/user.conf"
ENV KEA_VERSION="2-4"

COPY ["kea/docker-run" ,"/usr/local/bin/"]
COPY ["kea/db.cnf" ,"/etc/my.cnf.d/"]
COPY ["kea/kea.conf" ,"/usr/local/src/"]
COPY ["${CONFIG_FILE}" ,"/usr/local/src/user.conf"]

RUN apk add --no-cache curl bash && \
    curl -1sLf https://dl.cloudsmith.io/public/isc/kea-${KEA_VERSION}/setup.alpine.sh | \
    bash
RUN apk update && \
    apk add tzdata isc-kea isc-kea-admin isc-kea-dhcp-ddns mariadb-client

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN chmod 775 /usr/local/bin/docker-run 

ENTRYPOINT [ "docker-run" ]