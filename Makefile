# -q: --quiet

all: init-script
	echo "Launching"
	@mkdir -p $(HOME)/nmunoz.42.fr/wordpress
	@mkdir -p $(HOME)/nmunoz.42.fr/mariadb
	sudo docker-compose -f srcs/docker-compose.yml up --build -d > /dev/null 2> /dev/null
	echo "Launched"

reload: init-script
	echo "Launching"
	@mkdir -p $(HOME)/nmunoz.42.fr/wordpress
	@mkdir -p $(HOME)/nmunoz.42.fr/mariadb
	sudo docker-compose -f srcs/docker-compose.yml up --build -d > /dev/null 2> /dev/null
	echo "Launched"

stop:
	echo "Stopping"
	sudo docker-compose -f srcs/docker-compose.yml down > /dev/null 2> /dev/null
	echo "Stopped"

clean: stop
	echo "Removing"
	sudo docker-compose -f srcs/docker-compose.yml down --volumes --rmi all > /dev/null 2> /dev/null
	echo "Removed"

prune: clean
	echo "Pruning"
	sudo docker system prune -f > /dev/null 2> /dev/null
	echo "Pruned"

re: prune reload

init-script:
	sudo bash ./srcs/tools/init_script.sh

.PHONY: all stop clean prune re reload
.SILENT: all stop clean prune re reload


all: init-script

	@mkdir -p $(HOME)/nmunoz.42.fr/wordpress
	@mkdir -p $(HOME)/nmunoz.42.fr/mariadb
	@docker-compose -f ./srcs/docker-compose.yml up

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f srcs/docker-compose.yml up --build

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\
	rm -rf $(HOME)/nmunoz.42.fr/wordpress
	rm -rf $(HOME)/nmunoz.42.fr/mariadb

.PHONY: all re down clean


