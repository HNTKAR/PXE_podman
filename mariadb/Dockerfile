FROM mariadb

VOLUME [ "/sock" ]

ENV MARIADB_ROOT_PASSWORD="password"
COPY ["mariadb/my.cnf","/etc/mysql/"]
COPY ["mariadb/kea.sql","/docker-entrypoint-initdb.d/"]

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN chown -R root:root /docker-entrypoint-initdb.d

CMD ["--socket","/sock/mysql.sock"]