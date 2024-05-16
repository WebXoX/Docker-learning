# FROM alpine:3.18

# # Install necessary packages
# RUN apk update && \
#     apk add mariadb mariadb-client mariadb-server-utils

# # Expose the MySQL port
# EXPOSE 3306

# # Add and configure the setup script
# ADD setup.sh /scripts/setup.sh
# RUN chmod +x /scripts/setup.sh

# # Run setup script and change to mysql user
# RUN /scripts/setup.sh

# USER mysql

# # Command to run MariaDB
# CMD ["/usr/bin/mysqld", "--skip-log-error"]

# # https://wiki.alpinelinux.org/wiki/MariaDB


FROM alpine:3.18



RUN apk update && apk add --no-cache mariadb mariadb-client

EXPOSE 3306

COPY ./setup.sh .

RUN sh setup.sh && rm setup.sh

USER mysql

CMD ["/usr/bin/mysqld", "--skip-log-error"]