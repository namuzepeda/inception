FROM debian:bullseye

RUN apt-get update && apt-get upgrade && apt-get install -y mariadb-server sudo

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/db.sh /

RUN chmod +x ./db.sh

# CMD ["tail", "/dev/null"]
ENTRYPOINT ["/db.sh"]
