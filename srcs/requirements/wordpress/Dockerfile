FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y php php-mysql php-fpm wget

RUN apt-get install default-mysql-client -y

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d
COPY ./tools/run.sh /var/www/

RUN chmod +x /var/www/run.sh

ENTRYPOINT [ "/var/www/run.sh" ]

CMD ["/usr/sbin/php-fpm7.4", "--nodaemonize"]
