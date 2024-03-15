FROM nginx:latest

RUN apt-get update && \
    apt-get install -y ufw sudo vim

#RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
#COPY nginx.conf /etc/nginx/conf.d/s

# RUN openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
RUN mkdir /etc/nginx/sites-enabled
#RUN ln -s /etc/nginx/sites-available/www.data-lair.com /etc/nginx/sites-enabled/
#RUN ln -s /etc/nginx/sites-available/dev.data-lair.com /etc/nginx/sites-enabled
EXPOSE 80
EXPOSE 443