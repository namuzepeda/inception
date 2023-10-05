# -q: --quiet

all:
	echo "Launching"
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mariadb
	sudo docker compose -f srcs/docker-compose.yml up --build -d
	echo "Launched"

reload:
	echo "Launching"
	@mkdir -p $(HOME)/data/wordpress
	@mkdir -p $(HOME)/data/mariadb
	sudo docker compose -f srcs/docker-compose.yml up --build -d
	echo "Launched"

stop:
	echo "Stopping"
	sudo docker compose -f srcs/docker-compose.yml down
	echo "Stopped"

clean: stop
	echo "Removing"
	sudo docker compose -f srcs/docker-compose.yml down --volumes --rmi all
	echo "Removed"

prune: clean
	echo "Pruning"
	sudo docker system prune -f
	echo "Pruned"

re: prune reload

.PHONY: all stop clean prune re reload
.SILENT: all stop clean prune re reload