NAME = Inception

RED = \033[1;31m
GREEN = \033[1;32m
YELLOW = \033[1;33m
BLUE = \033[1;34m
RESET = \033[0m

all: $(VOLUME) build up

$(VOLUME):
	@if [ ! -d "${HOME}/data/"  ]; then mkdir -p ~/data/mariadb; mkdir -p ~/data/wordpress; fi

build:	
	@printf "$(BLUE)BUILDING$(RESET):\r\t\t\t\t\t\n"
	@docker-compose -f  ./srcs/docker-compose.yml  build --pull 

up:
	@printf "$(GREEN)RUNNING$(RESET):\r\t\t\t\t\t\n"
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@printf "$(RED)RUNNING$(RESET):\r\t\t\t\t\t\n"
	@docker-compose -f ./srcs/docker-compose.yml down -v --remove-orphans

start:
	@printf "$(GREEN)RUNNING$(RESET):\r\t\t\t\t\t\n"
	@docker-compose -f ./srcs/docker-compose.yml start

restart:
	@printf "$(GREEN)RESTARTING$(RESET):\r\t\t\t\t\t\n"
	@docker-compose -f ./srcs/docker-compose.yml restart
stop:
	@printf "$(YELLOW)STOPPING$(RESET):\r\t\t\t\t\t\n"
	@docker-compose -f ./srcs/docker-compose.yml stop
	@printf "$(RED)STOPED(RESET):\r\t\t\t\t\t\n"
log:
	@printf "$(BLUE)LOGS$(RESET):\r\t\t\t\t\t\n"
	@docker-compose -f ./srcs/docker-compose.yml logs

clean: down 
	@printf "$(YELLOW)CLEANING$(RESET):\r\t\t\t\t\t\n"
	@ rm -rf ~/data/mariadb; rm -rf ~/data/wordpress;
	@printf "$(RED)CLEANED$(RESET):\r\t\t\t\t\t\n"

fclean: clean 
	@docker system prune --all --force
	@docker network prune --force
	@docker volume prune --force

re: clean all

maria:
	@printf "$(GREEN)RUNNING MARIA$(RESET):\r\t\t\t\t\t\n"
	@docker-compose -f ./srcs/docker-compose.yml exec mariadb /bin/sh
wordpress:
	@printf "$(GREEN)RUNNING WORDPRESS$(RESET):\r\t\t\t\n"
	@docker-compose -f ./srcs/docker-compose.yml exec wordpress /bin/sh
nginx:
	@printf "$(GREEN)RUNNING NGINX$(RESET):\r\t\t\t\n"
	@docker-compose -f ./srcs/docker-compose.yml exec nginx /bin/sh

	