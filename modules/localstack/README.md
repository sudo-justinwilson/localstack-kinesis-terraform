# Kinesis in a localstack testing environment

## Assumptions
- This Terraform stack was built on an Ubuntu host, but any Linux host should suffice.
- Docker should be installed, and the user that builds the stack should have privileges to make calls to the Docker daemon.

## Overview
This module builds the following:
- A localstack test environment in a Docker container.

## To build
1) Install Terraform by following instructions [here](https://learn.hashicorp.com/terraform/getting-started/install.html)
5) Once Terraform is installed and the terraform command is available, run the following commands to build the environment
+ $ `terraform init`
+ $ `terraform plan`  		# this command ensures that the syntax is okay
+ $ `terraform apply`		# this command may need to be run several times to ensure all resources are created correctly
2) On completion, point your browser at http://localhost:8080 to view the localstack resources that have been created. You should also be able to see a container called terraform_localstack running with the command `docker ps`.
