FROM ubuntu:latest
MAINTAINER Said Sef <said@saidsef.co.uk>

RUN apt-get update
RUN apt-get upgrade -yq
RUN apt-get install -yq apt-utils lsof
RUN adduser --disabled-password --gecos '' node
RUN adduser node sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get install -yq nginx-extras

RUN apt-get -yq clean
RUN apt-get -yq autoclean
RUN apt-get -yq autoremove
RUN apt-get -yq purge

ADD config/custom.conf /etc/nginx/conf.d/

EXPOSE 80

WORKDIR ~/

CMD /usr/sbin/nginx -g "daemon off;"