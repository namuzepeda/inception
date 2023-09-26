# -f: --file
# -q: --quiet
all: init-script

	@mkdir -p $(HOME)/nmunoz.42.fr/wordpress
	@mkdir -p $(HOME)/nmunoz.42.fr/mariadb
	@docker-compose -f ./srcs/docker-compose.yml up

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f srcs/docker-compose.yml up --build

clean:

.PHONY: all re down clean

init-script:
    sudo ./srcs/init_script.sh
