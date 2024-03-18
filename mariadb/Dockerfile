FROM mariadb

ENV MARIADB_RANDOM_ROOT_PASSWORD="true"
ENV TZ='Asia/Tokyo'

VOLUME [ "/sock" ]

COPY ["user.cnf" , "/etc/mysql/conf.d/99-user.cnf"]
COPY ["kea.sql" , "/docker-entrypoint-initdb.d/00-kea.sql"]