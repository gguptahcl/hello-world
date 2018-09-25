# This Repository has 2 purposes. Both are defined in PART 1 and PART 2 below

# PART 1 : Docker Deployment on AWS Elastic Beanstalk 

Purpose of this repo is to setup process of Docker-based applications deployment on AWS Elastic Beanstalk. For setting up AWS Elastic Bean Stalk Env please refer https://github.com/gguptahcl/aws-elastic-beanstalk-terraform.git

### Prerequisities
- AWS IAM Role with access to IAM, EC2, Beanstalk & Elastic Container Registry/Engine and it's access & secret keys. Profile must be set inside `~/.aws/credentials` directory.
- Docker

### Contents of repo
 - src folder ,POM.xml, Dockerfile  - Code for creating a docker image for Spring Boot application
 - Dockerrun.aws.json - AWS Beanstalk standard task definition. Tells Beanstalk which image from ECR it should use
 - deploy_to_aws_ebs.sh - script for deploying applications. Elastic Bean Stalk App must be first set up (https://github.com/gguptahcl/aws-elastic-beanstalk-terraform.git)
 - clean.sh - script for cleaning temporary files

### Setup
1. AWS Elastic Bean Stalk env should be up and running.
2. Run deploy_to_aws_ebs.sh , it will ask for Application Name , EBS env , Region , AWS Account ID, AWS Access key ID and secret access key. Application name , EBS env , Region should be same which were used in setting up Elastic Bean Stalk Env.

### Rollbacking setup
```
terraform destroy  (destroy AWS Elastic Bean Stalk env created using https://github.com/gguptahcl/aws-elastic-beanstalk-terraform.git)
```

### Manual deployment

run deploy_to_aws_ebs.sh 


# PART 2 : Building a docker image and push to AWS ECR 

Purpose of this repo is to setup process of building docker image and push to AWS ECR. This can be used for use cases where multiple containers need to be deployed on ECS Cluster.One such example where it is being used is https://github.com/gguptahcl/aws-ecs-terraform-single-service-multi-containers.git

### Prerequisities
- AWS IAM Role with access to IAM, EC2, Beanstalk & Elastic Container Registry/Engine and it's access & secret keys. Profile must be set inside `~/.aws/credentials` directory.
- Docker

### Contents of repo
 - src folder ,POM.xml, Dockerfile  - Code for creating a docker image for Spring Boot application
 - build_push_ecr.sh - script for building docker image and pushing to ECR. ECR Repository should already exist and ECR repository name should be same as NAme variable in build_push_ecr.sh
 - clean.sh - script for cleaning temporary files

### Setup
1. Run build_push_ecr.sh , it will ask for Region , AWS Account ID, AWS Access key ID and secret access key. Application name , EBS env , Region should be same where ECR repository exists.

### Rollbacking setup

### Manual deployment

run build_push_ecr.sh 

