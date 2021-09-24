# This file builds a Docker image containing the academic CLI
# https://github.com/wowchemy/hugo-academic-cli/

# Copyright (C) 2021 David Frantz

#FROM klakegg/hugo:ext-ubuntu as builder
FROM ubuntu:20.04 as builder

# disable interactive frontends
ENV DEBIAN_FRONTEND=noninteractive 

# Refresh package list & upgrade existing packages 
RUN apt-get -y update && apt-get -y upgrade && \ 
#
# Add PPA for Python 3.x and R 4.0
apt -y install software-properties-common && \
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
add-apt-repository -y ppa:deadsnakes/ppa && \
#
# Install libraries
apt-get -y install \
  python3.8 \
  python3-pip && \
#
# Set python aliases for Python 3.x
echo 'alias python=python3' >> ~/.bashrc \
  && echo 'alias pip=pip3' >> ~/.bashrc \
  && . ~/.bashrc && \
#
# install academic CLI
pip install -U academic==0.5.1 && \
#
# Clear installation data
apt-get clean && rm -r /var/cache/

# Create a dedicated 'docker' group and user
RUN groupadd docker && \
  useradd -m docker -g docker -p docker && \
  chmod 0777 /home/docker && \
  chgrp docker /usr/local/bin && \
  mkdir -p /home/docker/bin && chown docker /home/docker/bin
# Use this user by default
USER docker

ENV HOME /home/docker
ENV PATH "$PATH:/home/docker/bin"

WORKDIR /home/docker
