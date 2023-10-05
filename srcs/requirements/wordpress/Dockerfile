FROM debian:buster

RUN apt-get update && apt-get -y install php7.3 php-mysql php-fpm wget

RUN apt install default-mysql-client -y

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./tools/run.sh /var/www/

RUN chmod +x /var/www/run.sh

ENTRYPOINT [ "/var/www/run.sh" ]

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]
