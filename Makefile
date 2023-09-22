# -f: --file
# -q: --quiet
# $$: escape $ for shell
all:
	@mkdir -p $(HOME)/inception/wordpress
	@mkdir -p $(HOME)/inception/mariadb
	@docker-compose -f ./srcs/docker-compose.yml up

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f srcs/docker-compose.yml up --build

clean:

.PHONY: all re down clean
