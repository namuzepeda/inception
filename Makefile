# -f: --file
# -q: --quiet
# $$: escape $ for shell
all: check-docker check-docker-compose

	@mkdir -p $(HOME)/nmunoz.42.fr/wordpress
	@mkdir -p $(HOME)/nmunoz.42.fr/mariadb
	@docker-compose -f ./srcs/docker-compose.yml up

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f srcs/docker-compose.yml up --build

clean:

.PHONY: all re down clean

check-docker:
    @f [ -z "$(shell command -v docker 2> /dev/null)" ]; then \
		echo "Installing Docker..."
        sudo apt-get update -y
		sudo apt-get upgrade -y
		sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
		curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
		echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		sudo apt update
		sudo apt install docker-ce docker-ce-cli containerd.io
    else \
        echo "Skipping Docker installation..."; \
    fi

check-docker-compose:	
	@if [ -z "$(shell command -v docker-compose 2> /dev/null)" ]; then \
		echo "Installing docker-compose; \
		sudo apt-get install -y docker-compose; \
	else \
		echo "Skipping docker-compose installation"; \
	fi
