#!/bin/bash

# remove all containers
docker rm -v -f $(docker ps -qa)

# remove all images and networks
dokcer system prune -a

# remove all volumes
docker volume prune -a
