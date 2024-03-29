FROM alpine

ARG ZONE_DIR="sample"
ARG CONFIG_FILE="bind9.conf"
ENV TZ='Asia/Tokyo'

COPY ["${ZONE_DIR}/*", "${CONFIG_FILE}", "/conf/"]

RUN apk add --no-cache bind
RUN mv /conf/${CONFIG_FILE} /etc/bind/user.conf

ENTRYPOINT [ "named" , "-u" , "named" ,"-c" , "/etc/bind/user.conf" ]
CMD [ "-g" ]