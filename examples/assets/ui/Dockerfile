FROM nginx:alpine

COPY assets/ui/proxy.conf /etc/nginx/conf.d/default.conf
COPY build/html /usr/share/nginx/html

EXPOSE 80

CMD nginx -g "daemon off;"