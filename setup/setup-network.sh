#!/bin/bash

# remove all networks
podman network prune -f

# create networks
podman network create --driver=bridge --ipv6=false --subnet=180.0.0.0/16 --gateway=180.0.0.1 net0__hl__proxy
podman network create --driver=bridge --ipv6=false --subnet=180.10.0.0/16 --gateway=180.10.0.1 net1__hl__private
podman network create --driver=bridge --ipv6=false --subnet=180.20.0.0/16 --gateway=180.20.0.1 net2__hl__public
podman network create --driver=bridge --ipv6=false --subnet=180.30.0.0/16 --gateway=180.30.0.1 net3__hl__monitoring
podman network create --driver=bridge --ipv6=false --subnet=180.40.0.0/16 --gateway=180.40.0.1 net4__hl__store
podman network create --driver=bridge --ipv6=false --subnet=180.50.0.0/16 --gateway=180.50.0.1 net5__hl__broker
