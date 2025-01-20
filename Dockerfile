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

# Add crontab for R code execution
RUN echo "0 9,12,15 * * 6-7 /usr/bin/Rscript /opt/epl/scripts/your_script.R" > /etc/cron.d/epl-cron \
 && echo "0 9,12,15 * * 3 /usr/bin/Rscript /opt/epl/scripts/your_script.R" >> /etc/cron.d/epl-cron \
 && chmod 0644 /etc/cron.d/epl-cron \
 && crontab /etc/cron.d/epl-cron

# Ensure cron service starts
RUN touch /var/log/cron.log

# Second stage: nginx-code
FROM nginx:alpine AS nginx-code

WORKDIR /opt/nginx

# Install necessary tools for Alpine
RUN apk update && apk add --no-cache \
  dcron \
  bash \
  curl

# Set permissions and create necessary directories
RUN chown -R nginx:nginx /usr/share/ && \
    mkdir -p /usr/share/data/www

# Copy files from the first stage
COPY --from=R-code /opt/epl .

# Serve the EPL table HTML
COPY --from=R-code /opt/epl/EPLTable.html /usr/share/data/www

RUN mv /usr/share/data/www/EPLTable.html /usr/share/data/www/index.html

# Configure nginx
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.ORIGINAL 

# Add script to ensure cron runs in the final container
COPY --from=R-code /opt/epl/scripts/nginx.conf /etc/nginx/nginx.conf
#COPY /opt/nginx/scripts/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

# Start cron and nginx when the container runs
CMD ["/bin/sh", "-c", "crond -f -l 2 && nginx -g 'daemon off;'"]

