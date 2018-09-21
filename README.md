 # Docker Deployment on AWS Elastic Beanstalk 

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


