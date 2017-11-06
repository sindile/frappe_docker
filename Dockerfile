
#bench Dockerfile

FROM ubuntu:16.04
MAINTAINER Vishal Seshagiri

USER root
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    build-essential \
    git \
    iputils-ping \
    libffi-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    libtiff5-dev \
    libxext6 \
    libxrender1 \
    libwebp-dev \
    python-dev \
    python-setuptools \
    python-tk \
    redis-tools \
    software-properties-common \
    tcl8.6-dev \
    tk8.6-dev \
    wget \
    xfonts-75dpi \
    xfonts-base libjpeg8-dev \
    zlib1g-dev \
    curl \
    rlwrap \
    redis-tools \
    nano \
    wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
    pip install --upgrade setuptools pip
    useradd -ms /bin/bash frappe
&& rm -rf /var/lib/apt/lists/*


#nodejs
RUN apt-get install curl
RUN curl https://deb.nodesource.com/node_6.x/pool/main/n/nodejs/nodejs_6.7.0-1nodesource1~xenial1_amd64.deb > node.deb \
 && dpkg -i node.deb \
 && rm node.deb
RUN apt-get install -y wkhtmltopdf

USER frappe
WORKDIR /home/frappe
RUN git clone -b develop https://github.com/frappe/bench.git bench-repo

USER root
RUN pip install -e bench-repo
RUN apt-get install -y libmysqlclient-dev mariadb-client mariadb-common
RUN chown -R frappe:frappe /home/frappe/*

USER frappe
WORKDIR /home/frappe/frappe-bench
