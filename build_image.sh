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
# 

set -e
start=`date +%s`

#Application Name
NAME=helloworldservice

VERSION=$(date +%s)


# Build the image
mvn package
docker build -t $NAME:$VERSION .

end=`date +%s`

echo Deploy ended with success! Time elapsed: $((end-start)) seconds

