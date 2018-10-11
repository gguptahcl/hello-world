#!/bin/bash
# Script used to deploy applications to AWS Elastic Beanstalk
#
# Does three things:
# 1. Builds Docker image & pushes it to container registry
#
# REQUIREMENTS!
# - ECR Repository should exist -- reposiroty name should be same as Name variable
# - AWS_ACCOUNT_ID env variable
# - AWS_ACCESS_KEY_ID env variable
# - AWS_SECRET_ACCESS_KEY env variable
#
# usage: ./deploy.sh name-of-application staging us-east-1 f0478bd7c2f584b41a49405c91a439ce9d944657

set -e
start=`date +%s`


# Build the image
mvn package

docker build -t ggupta0109/hello-world-docker:latest .

docker login 

docker push ggupta0109/hello-world-docker:latest


