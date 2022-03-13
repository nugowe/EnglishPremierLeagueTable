FROM rocker/tidyverse

WORKDIR /opt/epl

ENV TZ="America/Chicago"

COPY . .

RUN apt-get update && apt-get install -yq \
  curl \
  apt-utils \
  awscli 

# update indices
RUN apt update -qq
# install two helper packages we need
RUN apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: 298A3A825C0D65DFD57CBB651716619E084DAB9
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed
RUN add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

RUN apt install --no-install-recommends r-base

RUN apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
    

    
CMD ["/bin/bash"]

ENTRYPOINT ["/opt/epl/scripts/build.sh"]