#!/bin/bash
docker run --name rancher-server  -d --restart=always -p 8080:8080 rancher/server:v1.0.2
# Tail the logs to show Rancher
docker logs -f rancher-server
