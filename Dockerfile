FROM ubuntu:22.04

RUN apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y apache2 php php-cli php-mysql unzip curl npm git && \
    apt-get clean

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install || true
RUN npm install || true

EXPOSE 8090

CMD php artisan serve --host=0.0.0.0 --port=8090
