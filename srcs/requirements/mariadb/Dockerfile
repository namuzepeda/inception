FROM debian:buster

RUN apt update && apt install -y mariadb-server sudo && apt clean

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/db.sh /

RUN chmod +x ./db.sh

# CMD ["tail", "/dev/null"]
ENTRYPOINT ["/db.sh"]
