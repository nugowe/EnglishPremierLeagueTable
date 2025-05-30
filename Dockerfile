FROM rocker/tidyverse As R-code

WORKDIR /opt/epl

ENV TZ="America/Chicago"

COPY . .

RUN apt-get update && apt-get install -yq \
  curl \
  apt-utils 

RUN apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
    
RUN bash /opt/epl/scripts/build.sh

FROM node:16-slim

RUN npm install -g http-server
    
#FROM nginx:alpine AS nginx-code

WORKDIR /opt/nginx

#RUN chown -R nginx:nginx /usr/share/

#RUN mkdir /usr/share/data && mkdir /usr/share/data/www

COPY --from=R-code /opt/epl/TableEPL.html .

#COPY --from=R-code /opt/epl/EPLTable.html /usr/share/data/www

#RUN mv /usr/share/data/www/EPLTable.html /usr/share/data/www/index.html

#RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.ORIGINAL && touch /etc/nginx/nginx.conf 

#RUN sh /opt/nginx/scripts/nginx.sh

EXPOSE 8080

#ENTRYPOINT ["nginx", "-g", "daemon off;"]

ENTRYPOINT ["http-server", ".", "-p", "8080"]