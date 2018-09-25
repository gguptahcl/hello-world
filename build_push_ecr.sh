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

# AWS Region where app should be deployed e.g. `us-east-1`, `eu-central-1`
read -s -p "Please Enter Application Region, It should be same as in ELastic Bean stalk Set up : " app_region
echo -e  " \n Application Deployment Region is : "  $app_region
REGION=$app_region

# AWS Account ID
read -s -p "Please Enter AWS Account ID, It should be same as in ELastic Bean stalk Set up : " aws_acct_id
echo -e  " \n AWS Account ID is : "  $aws_acct_id
AWS_ACCOUNT_ID=$aws_acct_id

VERSION=$(date +%s)

echo "version is " $VERSION
echo Deploying $NAME to environment $STAGE, region: $REGION, version: $VERSION, bucket: $EB_BUCKET

echo We will need your AWS Credentials to Push Application to ECR

aws configure 
#aws configure set default.region $REGION
#aws configure set default.output json

# Login to AWS Elastic Container Registry
eval $(aws ecr get-login --no-include-email)

# Build the image
mvn package
docker build -t $NAME:$VERSION .

# Tag it
docker tag $NAME:$VERSION $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$NAME:$VERSION
docker tag $NAME:$VERSION $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$NAME:latest

# Push to AWS Elastic Container Registry
docker push $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$NAME:$VERSION
docker push $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$NAME:latest

end=`date +%s`

echo Deploy ended with success! Time elapsed: $((end-start)) seconds

