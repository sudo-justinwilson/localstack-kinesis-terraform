# Kinesis in a localstack testing environment

## Assumptions
- Docker should be installed, and the user that builds the stack should have privileges to make calls to the Docker daemon.
- This docker container generates random numbers and sends them to a kinesis stream.

## Overview
This module builds the following:
- A Docker container that generates random numbers and sends the random data to Kinesis.

## To build
1) Install Terraform by following instructions [here](https://learn.hashicorp.com/terraform/getting-started/install.html)
2) In a text editor, edit the ./variables.tf file and change the path variable to the absolute path of this repository. (The 'source' directive in the `docker_container.mounts` resource only seems to accept absolute paths)
3) Once Terraform is installed and the terraform command is available, run the following commands to build the environment
+ $ `terraform init`
+ $ `terraform plan`  		# this command ensures that the syntax is okay
+ $ `terraform apply`		# this command may need to be run several times to ensure all resources are created correctly
4) On completion, you should have a container that generates random numbers and sends it to a kinesis stream. Use the `docker ps` command to ensure that you have a container named `random_generator` running. You can also inspect the output with the command `docker logs -f random_generator`.
