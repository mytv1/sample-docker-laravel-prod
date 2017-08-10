FROM nginx:1.10-alpine

ADD /conf/web/prod.vhost.conf /etc/nginx/conf.d/default.conf
