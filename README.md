# Kinesis in a localstack testing environment

This repository builds the following components:

![localstack kinesis diagram](https://github.com/sudo-justinwilson/localstack-kinesis-terraform/blob/master/localstack-diagram.png)

## Getting Started

This repo builds the following:
* A localstack test environment in a Docker container.
* A kinesis stream instance called "terraform-kinesis-firehose-test-stream".
* A kinesis Firehose instance called "terraform-kinesis-firehose-test-stream" that loads data from the kinesis stream and sends the data to an S3 bucket.
* An S3 bucket called "s3:::tf-test-bucket"
* A Docker container that generates random numbers and sends the random data to Kinesis.

### Prerequisites

- This Terraform stack was built on an Ubuntu host, but any Linux host should suffice.
- Docker should be installed, and the user that builds the stack should have privileges to make calls to the Docker daemon.

## Deployment

Use the following steps to deploy the stack.

1) Clone the repository:

```
git clone https://github.com/sudo-justinwilson/localstack-kinesis-terraform.git
```

2) Change to the repo directory:

```
cd ${/PATH/TO/REPO}
```

3) In a text editor, edit the ${REPO}/variables.tf file and change the path variable to the absolute path of the repository. (The 'source' directive in the 'docker_container.mounts resource only seems to accept absolute paths)

```
variable "path" {
  type        = string
  description = "The path to the current directory"
  default = "/home/justinwilson/workspaces/git/localstack-kinesis-terraform_old/modules/docker"
}
```

4) Install Terraform by following instructions [here](https://learn.hashicorp.com/terraform/getting-started/install.html)

5) Once Terraform is installed and the terraform command is available, run the following commands to build the environment

```
$ terraform init
$ terraform plan
$ terraform apply     
```
- _Note:_ The `terraform apply` command may need to be run several times while it waits for Localstack to come up and all it's services are available.

6) On completion, point your browser at http://localhost:8080 to view the localstack resources that have been created.

## Modules
Each directory in the 'modules/' directory is a Terraform module, that can be reused in other projects.
Dependencies can be controlled via the `depends_on` directive in the root './outputs.tf' file:

* docker
* kinesis
* localstack

## Interacting with localstack using awscli

You can also interact with the Localstack container using with awscli by setting the `--endpoint-url` flag:

```
$ aws --endpoint-url http://localhost:4573 firehose describe-delivery-stream --delivery-stream-name terraform-kinesis-firehose-test-stream
```

- _You can find which port each service listens to in .modules/localstack/main.tf_

### Tearing down the test environment

Once we're done testing, we can tear-down the environment with the following command:

```
$ terraform destroy
```

## Built With

* [Terraform](https://terraform.io) - Used to automate the building of infrastructure
* [Localstack](https://github.com/localstack/localstack) - Used for setting up local AWS environments for testing

## Contributing

Submit bugs & feature requests via [Github](https://github.com/sudo-justinwilson/localstack-kinesis-terraform)

## Authors

* **Justin Wilson** - *Initial work* - [Github](https://github.com/sudo-justinwilson/)

## License

This project is licensed under the GPL3.0 License - see the [LICENSE.md](LICENSE.md) file for details

