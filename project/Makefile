#The name of container : In some cases we will use this, for example, to display logs or to access a specific container by its name.
name = inception
#Run the configuration
all:
	@printf "Launch configuration ${name}...\n"
  #up : Build (re)creates, starts, and attaches to containes for a service.
    #-f:launch container, -d:detach in the background
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d
#Assembling the configuration
build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	#--build: build images before starting containers
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
#Stopping the configuration
down:
	@printf "Stopping configuration ${name}...\n"
	#down: stop container and removes containers, networkm volumes and images created by up
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

#Rebuilding the configuration
re: down
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
#Clear the configuration
clean: down
	@printf "Cleaning configuration ${name}...\n"
        #system : manage docker, prune: remove all unused containers, network, images, and optionally volumes/
        #-a:Remove all unused images not just dangling ones
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*
#Deep cleaning of all configuration
#Use it only when you want to build the entire project from scratch
fclean:
	@printf "Total clean of all configurations docker\n"
	#stop:Stop all the running containers
	#ps: List container -q: display container IDs -a:show all containers(default shows just running
	@docker stop $$(docker ps -qa)
	#-all: Remove all unused images not just dangling ones
        #--force: Do not prompt for confirmation
        #--volumes Prune volumes
	@docker system prune --all --force --volumes
	#network: manage network, prune:remove all unused networks, unused networks are those which are not referenced by any containes
        #--force : do not prompt for confirmation
	@docker network prune --force
	#volume prune: Remove all unused local volumes: Unused local volumes are those which are not referenced by any continers.
        #By default, it only removes anonymous volumes.
        #--force: Do not prompt for confirmation
	@docker volume prune --force
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

.PHONY	: all build down re clean fclean
