#! /bin/bash

sudo yum install docker -y \

sudo service docker start \

sudo chkconfig docker on

sudo chmod 777 /var/run/docker.sock

sudo docker run --restart=always -d --name sonar -p 9000:9000 \
-v sonar_data:/opt/sonarqube/data \
-v sonar_logs:/opt/sonarqube/logs \
-v sonar_extensions:/opt/sonarqube/extensions \
sonarqube:latest 

