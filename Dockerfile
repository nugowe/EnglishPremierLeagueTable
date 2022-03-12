FROM rocker/tidyverse

WORKDIR /opt/epl

ENV TZ="America/Chicago"

COPY . .

RUN apt-get update && apt-get install -yq \
  curl \
  apt-utils 


RUN apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
    

    
CMD ["/bin/bash"]

ENTRYPOINT ["/opt/epl/scripts/dockerbuild.sh"]