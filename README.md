# Kinesis in a localstack testing environment

## Assumptions
- This Terraform stack was built on an Ubuntu host, but any Linux host should suffice.
- Docker should be installed, and the user that builds the stack should have privileges to make calls to the Docker daemon.

## Overview
This repo builds the following:
- A localstack test environment in a Docker container.
- A kinesis stream instance called "terraform-kinesis-firehose-test-stream".
- A kinesis Firehose instance called "terraform-kinesis-firehose-test-stream" that loads data from the kinesis stream and sends the data to an S3 bucket.
- An S3 bucket called "s3:::tf-test-bucket"
- A Docker container that generates random numbers and sends the random data to Kinesis.

## To build
1) Clone this repository
..* $ git clone https://github.com/sudo-justinwilson/localstack-kinesis-terraform.git
2) cd ${/PATH/TO/REPO}
3) In a text editor, edit the ${REPO}/variables.tf file and change the path variable to the absolute path of the repository. (The 'source' directive in the 'docker_container.mounts resource only seems to accept absolute paths)
4) Install Terraform by following instructions [here](https://learn.hashicorp.com/terraform/getting-started/install.html)
5) Once Terraform is installed and the terraform command is available, run the following commands to build the environment
..* $ `terraform init`
..* $ `terraform plan`  		# this command ensures that the syntax is okay
..* $ `terraform apply`		# this command may need to be run several times to ensure all resources are created correctly
6) On completion, point your browser at http://localhost:8080 to view the localstack resources that have been created.
