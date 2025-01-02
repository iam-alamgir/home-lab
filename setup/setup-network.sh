#!/bin/bash

# remove all networks
docker network prune -a

# create networks
docker network create --driver=bridge --ipv6=false --attachable=true --subnet=180.0.0.0/16 --gateway=180.0.0.1 net0__hl__proxy
docker network create --driver=bridge --ipv6=false --attachable=true --subnet=180.10.0.0/16 --gateway=180.10.0.1 net1__hl__private
docker network create --driver=bridge --ipv6=false --attachable=true --subnet=180.20.0.0/16 --gateway=180.20.0.1 net2__hl__public
docker network create --driver=bridge --ipv6=false --attachable=true --subnet=180.30.0.0/16 --gateway=180.30.0.1 net3__hl__monitoring
docker network create --driver=bridge --ipv6=false --attachable=true --subnet=180.40.0.0/16 --gateway=180.40.0.1 net4__hl__store
docker network create --driver=bridge --ipv6=false --attachable=true --subnet=180.50.0.0/16 --gateway=180.50.0.1 net5__hl__broker
