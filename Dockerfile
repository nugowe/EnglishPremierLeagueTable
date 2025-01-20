# First stage: R-code
FROM rocker/tidyverse AS R-code

WORKDIR /opt/epl

ENV TZ="America/Chicago"

COPY . .

# Install necessary packages and set timezone
RUN apt-get update && apt-get install -yq \
  curl \
  apt-utils \
  awscli \
  systemd \
  sysvinit-utils \
  cron && \ 
  apt-get install -yq tzdata && \
  ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata

# Build script for R processing
RUN bash /opt/epl/scripts/build.sh

FROM node:18-alpine

WORKDIR /opt/webserver

RUN npm install -g http-server
   
COPY --from=R-code /opt/epl/EPLTable.html /opt/webserver/EPLTable.html

EXPOSE 8084

# Start cron and nginx when the container runs
CMD ["http-server", ".", "-p", "8084"]

