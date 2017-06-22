FROM node:8.1.2

RUN echo "deb http://nginx.org/packages/debian/ wheezy nginx" >> /etc/apt/sources.list.d/nginx.list
RUN apt-key adv --fetch-keys "http://nginx.org/keys/nginx_signing.key"
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install nginx openssl ca-certificates

RUN rm -rf /etc/nginx/conf.d/*
RUN rm -rf /srv/www/*


ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/default.conf /etc/nginx/conf.d/default.conf

ADD nginx/engage.crt /etc/nginx/cert/engage.crt
ADD nginx/engage.key /etc/nginx/cert/engage.key
ADD nginx/dhparam.pem /etc/nginx/cert/dhparam.pem

COPY . /usr/local/pge-engage
WORKDIR /usr/local/pge-engage

RUN ["yarn", "install"]
RUN ["npm", "run-script", "build"]
RUN ln -s /usr/local/pge-engage/build/ /srv/www

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["nginx"]
