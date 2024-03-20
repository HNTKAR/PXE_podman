FROM alpine

ARG CONFIG_DIR="sample"
ARG CONFIG_FILE="named-user.conf"
ENV TZ='Asia/Tokyo'

COPY ["${CONFIG_DIR}/*" ,"/conf/"]

RUN apk add --no-cache bind
RUN mv /conf/${CONFIG_FILE} /etc/bind/user.conf

ENTRYPOINT [ "named" , "-u" , "named" ,"-c" , "/etc/bind/user.conf" ]
CMD [ "-g" ]