#!/bin/bash

# System update + some basics
cat > /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

yum update -y 
yum install -y ntpdate wget curl vim docker-engine

# Config ntpd
ntpdate -u time.nist.gov
rm -rf /etc/localtime  && ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime

# Setup docker and preinstall rancher agent
chkconfig docker on
service docker start
docker pull rancher/agent:v1.0.1

# install docker-compose  (makes Juan happy)
curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "== Done!"
