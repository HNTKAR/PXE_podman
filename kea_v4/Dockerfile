FROM alpine

## MYSQL_UNIX_PORT
# https://dev.mysql.com/doc/refman/8.0/en/connecting.html

ARG CONFIG_FILE="sample.conf"
ENV MYSQL_UNIX_PORT="/sock/mysqld.sock"
ENV KEA_VER="2-5"
ENV TZ='Asia/Tokyo'

COPY ["kea.conf" ,"/usr/local/src/"]
COPY ["${CONFIG_FILE}" ,"/usr/local/src/user.conf"]

RUN apk add --no-cache bash curl tzdata mariadb-client && \
    curl -1sLf "https://dl.cloudsmith.io/public/isc/kea-${KEA_VER}/setup.alpine.sh" | \
    bash
RUN apk add --no-cache isc-kea

ENTRYPOINT [ "kea-dhcp4"]
CMD [ "-c" , "/usr/local/src/kea.conf" ]