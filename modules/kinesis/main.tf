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
