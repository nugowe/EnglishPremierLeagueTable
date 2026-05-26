FROM rocker/tidyverse:latest AS r_build

WORKDIR /opt/epl

ENV TZ=America/Chicago

COPY . .

RUN apt-get update && \
    apt-get install -y \
      curl \
      apt-utils \
      tzdata && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Run R build script
RUN bash /opt/epl/scripts/build.sh


# =========================
# NGINX STAGE
# =========================
FROM nginx:alpine

COPY . .

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=r_build \
  /opt/epl/TableEPL.html \
  /usr/share/nginx/html

COPY index.html /usr/share/nginx/html/index.html

COPY img/arsenal_champions.png /usr/share/nginx/html/arsenal_champions.png

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]