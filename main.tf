##### LOCALSTACK CONTAINER
# Configure the Docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Start a container
resource "docker_container" "localstack" {
  name  = "terraform_localstack"
  image = "localstack/localstack:latest"
  ports {
    internal = 8080
    external = 8080
  }
  ports {
    internal = 4563
    external = 4563
  }
  ports {
    internal = 4564
    external = 4564
  }
  ports {
    internal = 4565
    external = 4565
  }
  ports {
    internal = 4566
    external = 4566
  }
  ports {
    internal = 4567
    external = 4567
  }
  ports {
    internal = 4568
    external = 4568
  }
  ports {
    internal = 4569
    external = 4569
  }
  ports {
    internal = 4570
    external = 4570
  }
  ports {
    internal = 4571
    external = 4571
  }
  ports {
    internal = 4572
    external = 4572
  }
  ports {
    internal = 4573
    external = 4573
  }
  ports {
    internal = 4574
    external = 4574
  }
  ports {
    internal = 4575
    external = 4575
  }
  ports {
    internal = 4576
    external = 4576
  }
  ports {
    internal = 4577
    external = 4577
  }
  ports {
    internal = 4578
    external = 4578
  }
  ports {
    internal = 4579
    external = 4579
  }
  ports {
    internal = 4580
    external = 4580
  }
  ports {
    internal = 4581
    external = 4581
  }
  ports {
    internal = 4582
    external = 4582
  }
  ports {
    internal = 4583
    external = 4583
  }
  ports {
    internal = 4584
    external = 4584
  }
  ports {
    internal = 4585
    external = 4585
  }
  ports {
    internal = 4586
    external = 4586
  }
  ports {
    internal = 4587
    external = 4587
  }
  ports {
    internal = 4588
    external = 4588
  }
  ports {
    internal = 4589
    external = 4589
  }
  ports {
    internal = 4590
    external = 4590
  }
  ports {
    internal = 4591
    external = 4591
  }
  ports {
    internal = 4592
    external = 4592
  }
  ports {
    internal = 4593
    external = 4593
  }
  ports {
    internal = 4594
    external = 4594
  }
  ports {
    internal = 4595
    external = 4595
  }
  ports {
    internal = 4596
    external = 4596
  }
  ports {
    internal = 4597
    external = 4597
  }
  ports {
    internal = 4598
    external = 4598
  }
  ports {
    internal = 4599
    external = 4599
  }
  volumes {
    volume_name = "docker_socket"
    host_path = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }
  # Setting AWS_CBOR_DISABLE=1 is meant to fix the "Caught exception while sync'ing Kinesis shards and leases" localstack Kinesis error:
  env = ["DEBUG=1", "DATA_DIR=/tmp/localstack/data", "AWS_CBOR_DISABLE=1"]
}
##### LOCALSTACK CONTAINER
##### KINESIS
provider "aws" {
  access_key                  = var.access_key
  secret_key                  = var.secret_key
  region                      = var.region
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4567"
    cloudformation = "http://localhost:4581"
    cloudwatch     = "http://localhost:4582"
    dynamodb       = "http://localhost:4569"
    es             = "http://localhost:4578"
    firehose       = "http://localhost:4573"
    iam            = "http://localhost:4593"
    kinesis        = "http://localhost:4568"
    lambda         = "http://localhost:4574"
    route53        = "http://localhost:4580"
    redshift       = "http://localhost:4577"
    s3             = "http://localhost:4572"
    secretsmanager = "http://localhost:4584"
    ses            = "http://localhost:4579"
    sns            = "http://localhost:4575"
    sqs            = "http://localhost:4576"
    ssm            = "http://localhost:4583"
    stepfunctions  = "http://localhost:4585"
    sts            = "http://localhost:4592"
  }
}

resource "aws_kinesis_stream" "test_terraform_stream" {
  name             = "terraform-kinesis-test"
  shard_count      = 1
  retention_period = 48
  depends_on = [docker_container.localstack]

  tags = {
    Environment = "test"
    RunsIn      = "localstack"
  }
}

###
# KINESIS FIREHOSE CONFIG BELOW:
###

resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
  depends_on = [docker_container.localstack]
}

resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = "terraform-kinesis-firehose-test-stream"
  destination = "s3"
  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.test_terraform_stream.arn
    role_arn = var.firehose_role_arn
  } 
  depends_on = [aws_kinesis_stream.test_terraform_stream,aws_s3_bucket.bucket]

  s3_configuration {
    role_arn   = var.s3_role_arn
    bucket_arn = aws_s3_bucket.bucket.arn
  }
}
##### KINESIS
##### RANDOM CONTAINER
# Start a container
resource "docker_container" "random" {
  name  = "random_generator"
  image = "centos:latest"
  mounts {
    source = "${var.path}/aws"
    target = "/root/.aws"
    type = "bind"
  }
  mounts {
    source = "${var.path}/files"
    target = "/files"
    type = "bind"
  }

  entrypoint = ["/files/entrypoint.sh"]
  start = true
  depends_on = [aws_kinesis_stream.test_terraform_stream]
}
##### RANDOM CONTAINER
