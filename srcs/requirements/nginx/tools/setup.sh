#!/bin/sh
certbot --nginx -d ${DOMAIN} --email ${EMAIL} --agree-tos --non-interactive

# openssl genpkey -algorithm RSA -out /etc/ssl/private/nginx.key -pkeyopt rsa_keygen_bits:2048

# Generate the certificate
openssl req -new -x509 -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${ORGANIZATIONAL_UNIT}/CN=${DOMAIN}/emailAddress=${EMAIL}"

# nginx -g daemon off;
