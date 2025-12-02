This my application is a node js application , running on port 3000. 
# CloudCart — Scalable Web App on AWS (DevOps Project)

## Overview
Deploy a three-tier web app on AWS using Terraform for infra, Docker for container, GitHub Actions for CI/CD, CloudWatch for monitoring.

## Prerequisites
- AWS account & IAM user with programmatic keys
- Docker Hub account & token
- Terraform installed (recommended v1.4+)
- AWS CLI installed & configured
- GitHub repo for CI

## Quick steps

1. Clone repo
2. Edit `terraform/variables.tf` to set `dockerhub_username` and DB password OR supply them with `-var` at `terraform apply`.
3. (Recommended) Configure Terraform backend (S3 + DynamoDB) in `providers.tf`.
4. From `/terraform`:
   ```bash
   terraform init
   terraform apply -var="dockerhub_username=yourhub" -var="docker_image_tag=latest"


step 1- build code locally 
npm install; creates package.lock file
npm start to run on port 3000

step 2- build and run docker image locally
Cd into my app folder, where i have Dockerfile, docker build -t dockerhubname/cloudcart-sample:local-test
docker run -p 3000:3000 dockerhubname/cloudcart-sample:locat-test
Step 3- login , tag and push image to Docker hub