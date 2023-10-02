FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chown -R mysql:mysql /var/lib/mysql

COPY ./tools/run.sh /run_mariadb.sh
RUN chmod +x /run_mariadb.sh

ENTRYPOINT ["/run_mariadb.sh"]
