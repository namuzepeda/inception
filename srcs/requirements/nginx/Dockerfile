FROM debian:bullseye

RUN apt-get update && apt-get upgrade && apt-get install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/nmunoz.nginx.key -out /etc/ssl/certs/nmunoz.nginx.crt -subj "/C=TR/ST=Ile-de-France/L=Paris/O=42Paris/CN=nmunoz.42.fr";

COPY conf/nginx.conf /etc/nginx/sites-enabled/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
