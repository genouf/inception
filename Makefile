YML_PATH = ./srcs/docker-compose.yml

all:
	@docker-compose -f $(YML_PATH) up -d

down: 
	@docker-compose -f $(YML_PATH) down

re:
	@docker-compose -f $(YML_PATH) up --build --force-recreate -d

clean:
	@docker stop $$(docker ps -qa);\
    docker rm $$(docker ps -qa);\
    docker rmi -f $$(docker images -qa);\
    docker volume rm $$(docker volume ls -q);\
	rm -rf /home/genouf/data/mariadb/*;\
	rm -rf /home/genouf/data/wordpress/*;\
    docker network rm srcs_docker_network;\

.PHONY: all down re clean