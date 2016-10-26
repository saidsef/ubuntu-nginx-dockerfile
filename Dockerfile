#
# Nginx Dockerfile
#

# Pull base image
FROM alpine:latest
MAINTAINER Said Sef <said@saidsef.co.uk>

LABEL version="3.0"
LABEL description="Containerised nginx server"

ENV HOME /tmp

# Define working directory.
WORKDIR /data

# Update packages
RUN apk add --update wget curl nginx

# Clean up
RUN rm -rf /var/cache/apk/*

#  create build id
ARG BUILD_ID=""
RUN echo ${BUILD_ID} > build_id.txt

# Mount Nginx config
ADD config/custom.conf /etc/nginx/conf.d/

# Expose ports
# - 80: HTTP
EXPOSE 80

# Define default command
CMD ["/usr/sbin/nginx", " -g ", "daemon off;"]
