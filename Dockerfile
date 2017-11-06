FROM nginx:stable

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
  supervisor php5-fpm php5-cli && apt-get clean && rm -rf /var/lib/apt/lists/* \
  rm /etc/nginx/conf.d/default.conf && \
    sed -i \
        -e 's/^user  nginx;$/user www-data;/g' \
        /etc/nginx/nginx.conf

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir /etc/supervisor/conf.d/supervisord.conf.d
ADD entrypoint.sh /
ADD entrypoint.d/ /entrypoint.d
ADD php-fpm.conf /etc/php5/fpm/
CMD ["/entrypoint.sh"]
