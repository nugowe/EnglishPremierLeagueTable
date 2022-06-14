#!/bin/bash


echo """
events {
  worker_connections 768;
  # multi_accept on;
}
http {
  include  v.hosts/*.conf;
  server {
    location / {
           root /usr/share/data/www;
           index  index.html index.htm;
    }
  }
}
""" > $HOME/nginx.conf

cp -r /$HOME/nginx.conf /etc/nginx/nginx.conf

