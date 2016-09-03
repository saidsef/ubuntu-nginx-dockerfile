#
# Nginx Dockerfile
#

# Pull base image
FROM ubuntu:16.04
MAINTAINER Said Sef <said@saidsef.co.uk>

# Update packages
RUN apt-get update && \
    apt-get upgrade -yq && \
    apt-get install -yq apt-utils lsof && \
    apt-get install -yq nginx-extras && \
    apt-get -yq autoremove && \
    apt-get -yq clean && \
    apt-get -yq autoclean && \
    apt-get -yq purge

# Label
LABEL version="2.0"

# Add node user
RUN adduser --disabled-password --gecos '' node
RUN adduser node sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Mount Nginx config
ADD config/custom.conf /etc/nginx/conf.d/

# Expose ports
# - 80: HTTP
EXPOSE 80

# Define working directory
WORKDIR ~/

# Define default command
CMD ["/usr/sbin/nginx", " -g ", "daemon off;"]
