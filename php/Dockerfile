FROM php:7.4-fpm

RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
    curl gnupg wget zip unzip cron supervisor libpng-dev libjpeg-dev libfreetype6-dev
RUN rm -rf /var/lib/apt/lists/*

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y unixodbc-dev msodbcsql17

RUN docker-php-ext-install pdo pdo_mysql json bcmath
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd
RUN pecl install redis sqlsrv pdo_sqlsrv && docker-php-ext-enable redis sqlsrv pdo_sqlsrv

COPY ./crontab /var/spool/cron/crontabs/root
RUN chmod 0644 /var/spool/cron/crontabs/root
RUN crontab /var/spool/cron/crontabs/root

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./entrypoint.sh /usr/local/bin/

WORKDIR /code

ENTRYPOINT ["entrypoint.sh"]

CMD ["php-fpm"]
