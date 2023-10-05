# -f: --file
# -q: --quiet

all: init-script
	echo "Launching"
	sudo docker-compose -f srcs/docker-compose.yml up --build -d > /dev/null 2> /dev/null
	echo "Launched"

reload: init-script
	echo "Launching"
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