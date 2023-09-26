FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/data.sql /var/www/data.sql

RUN mkdir /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld/

COPY ./tools/run.sh /usr/local/bin/run_mariadb.sh

ENTRYPOINT ["/usr/local/bin/run_mariadb.sh"]

CMD ["mysqld", "--datadir=/var/run/mysqld"]
