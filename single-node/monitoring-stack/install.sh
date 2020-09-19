#!/bin/bash
#Requirements: docker, manager node of swarm, overlay network "single_node-net"

# Random password generation and creation of docker secrets
mkdir grafana/secrets/passwords
 admin_username="iudx_super_admin"
 admin_passwd=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=' | head -c 12) 
echo -n "$admin_passwd" > grafana/secrets/passwords/grafana-super-admin-passwd
echo "------------Grafana_details------------" > grafana/secrets/passwords/secrets.txt
echo "Grafana super admin details : username is iudx_super_admin and password is $admin_passwd" >> grafana/secrets/passwords/secrets.txt
mkdir  /tmp/metrics-targets

# deploying the monitoring-stack : Zookeeper, vertx_SD, Prometheus, Grafana,
# Loki, Promtail
docker stack deploy -c mon-stack.yml mon-stack

sleep 10 && echo "awake"

# creation of 3 grafana users


