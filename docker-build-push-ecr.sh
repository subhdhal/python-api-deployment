#!/bin/bash

# Auther - subhashreedhal05@gmail.com
# Input - AWS_DEFAULT_REGION, AWS_ACCOUNT_ID as enviroment variable
# Output - In the end of the script you will get a JSON file with the ECR repositoryUri

# Get the Python API repo and build the docker image
DOCKER_IMAGE_NAME="python-api-demo"
DOCKER_IMAGE_VERSION="latest"
docker build -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION .
echo "Image build successful"

# login to ecr, needs to make sure the aws-cli v2 configuration is done for authentication 
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com
# create the ecr repo
ECR_REPO_NAME=$DOCKER_IMAGE_NAME
aws ecr describe-repositories --repository-names $ECR_REPO_NAME || aws ecr create-repository --repository-name $ECR_REPO_NAME > my_ecr_repo.json
# re-tag
docker tag $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$ECR_REPO_NAME:$DOCKER_IMAGE_VERSION
# push
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$ECR_REPO_NAME:$DOCKER_IMAGE_VERSION

echo "ECR Image URI -"
cat my_ecr_repo.json | grep repositoryUri
