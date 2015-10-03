#
# Nginx Dockerfile
#

# Pull base image
FROM ubuntu:latest
MAINTAINER Said Sef <said@saidsef.co.uk>

# Update packages
RUN apt-get update
RUN apt-get upgrade -yq
RUN apt-get install -yq apt-utils lsof

# Add node user
RUN adduser --disabled-password --gecos '' node
RUN adduser node sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Install Nginx
RUN apt-get install -yq nginx-extras

# Clean up
RUN apt-get -yq autoremove
RUN apt-get -yq clean
RUN apt-get -yq autoclean
RUN apt-get -yq purge

# Mount Nginx config
ADD config/custom.conf /etc/nginx/conf.d/

# Expose ports
# - 80: HTTP
EXPOSE 80

# Define working directory
WORKDIR ~/

# Define default command
CMD /usr/sbin/nginx -g "daemon off;"