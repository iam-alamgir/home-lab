#!/bin/bash

# remove all containers
podman rm -v -f $(podman ps -qa)

# remove all images and networks
podman system prune -a -f

# remove all volumes
podman volume prune -f
