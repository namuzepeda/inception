FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server

EXPOSE 3306

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal --skip-test-db

COPY ./conf/my.cnf /etc/mysql/my.cnf

RUN mkdir /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld /var/lib/mysql 

COPY ./tools/run.sh /usr/local/bin/run_mariadb.sh
RUN chmod +x /usr/local/bin/run_mariadb.sh

ENTRYPOINT ["/usr/local/bin/run_mariadb.sh"]

CMD ["mysqld", "--datadir=/var/lib/mysql"]
