#!/bin/sh
certbot --nginx -d ${DOMAIN} --email ${EMAIL} --agree-tos --non-interactive

# Generate the certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${ORGANIZATIONAL_UNIT}/CN=${DOMAIN}/emailAddress=${EMAIL}"
