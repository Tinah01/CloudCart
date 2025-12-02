#!/bin/bash
set -e

# install docker
yum update -y
amazon-linux-extras install docker -y || (yum install -y docker)
service docker start
usermod -a -G docker ec2-user

# install awslogs if desired (optional; using docker awslogs driver)
yum install -y awslogs || true

# create log group (CloudWatch log group will be created by Terraform; ensure region)
# pull and run exporter containers (node exporter and cAdvisor are useful)
docker run -d --name node_exporter --net=host prom/node-exporter:latest || true
docker run -d --name cadvisor -v /var/run/docker.sock:/var/run/docker.sock --publish=8080:8080 gcr.io/cadvisor/cadvisor:latest || true

# pull and run the app using awslogs docker driver so logs go to CloudWatch
docker pull ${image}
docker rm -f cloudcart || true
docker run -d --name cloudcart -p 3000:3000 \
  --restart unless-stopped \
  --log-driver awslogs \
  --log-opt awslogs-region=${aws_region} \
  --log-opt awslogs-group=${cw_log_group} \
  ${image}
