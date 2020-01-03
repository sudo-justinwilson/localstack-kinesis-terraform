# Kinesis in a localstack testing environment

## Assumptions
- This module assumes that there is a localstack instance running on the localhost with the default localstack ports exposed.

## Overview
This module builds the following:
- A kinesis stream instance called "terraform-kinesis-firehose-test-stream".
- A kinesis Firehose instance called "terraform-kinesis-firehose-test-stream" that loads data from the kinesis stream and sends the data to an S3 bucket.
- An S3 bucket called "s3:::tf-test-bucket"

## Inputs
The following inputs are defined in the variables.tf file:
- access_key      # note that this uses a mock key for localstack
- secret_key      # note that this uses a mock key for localstack
- region          # us-east-1 by default, but can be set in the localstack module with an environment variable

## To build
1) Install Terraform by following instructions [here](https://learn.hashicorp.com/terraform/getting-started/install.html)
2) Once Terraform is installed and the terraform command is available, run the following commands to build the environment
+ $ `terraform init`
+ $ `terraform plan`  		# this command ensures that the syntax is okay
+ $ `terraform apply`		# this command may need to be run several times to ensure all resources are created correctly
3) On completion, point your browser at http://localhost:8080 to view the localstack resources that have been created.
