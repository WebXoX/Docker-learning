command to run compose file
docker-compose -f docker-compose.yaml build && docker-compose -f docker-compose.yaml up -d
docker build . -t try \
  -e DOMAIN_NAME=your_domain.com \
  -e TITLE="Your WordPress Site Title" \
  -e ADM_USER=your_admin_username \
  -e ADM_EMAIL=your_admin_email \
  -e ADM_PASS=1 \
  -e WP_USER_PASS=1 \
  -e WP_USER=your_additional_username \
  -e WP_USER_EMAIL=your_additional_user_email
""
docker build . -t try \
  -e DOMAIN_NAME=jperinch.42.fr \
  -e TITLE="inception" \
  -e ADM_USER=admin \
  -e ADM_PASS=1 \
  -e WP_USER=joe \
  -e WP_USER_EMAIL=jperinch.42.fr \
  -e WP_USER_PASS=2

arg=$(docker ps | grep inception-mariadb | awk '{print $1}') ; docker logs $arg
arg=$(docker ps | grep inception-wordpress | awk '{print $1}') ; docker logs $arg
arg=$(docker ps | grep inception-nginx | awk '{print $1}') ; docker logs $arg