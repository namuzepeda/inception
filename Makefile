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
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\
	rm -rf $(HOME)/nmunoz.42.fr/wordpress
	rm -rf $(HOME)/nmunoz.42.fr/mariadb

.PHONY: all re down clean

init-script:
	sudo bash ./srcs/tools/init_script.sh
