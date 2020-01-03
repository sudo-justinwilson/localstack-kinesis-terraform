variable "access_key" {
  type        = string
  description = "The AWS access key that will be used for authentication (a fake one for Localstack)."
  default = "mock_access_key"
}

variable "secret_key" {
  type        = string
  description = "The AWS secret key that will be used for authentication (a fake one for Localstack)."
  default = "mock_secret_key"
}

variable "region" {
  type        = string
  description = "The region that will be used (us-east-1 is set as a variable for the Localstack Docker container)."
  default = "us-east-1"
}

variable "firehose_role_arn" {
  type        = string
  description = "The IAM role for Kinesis Firehose (a fake one for Localstack)."
  default = "arn:aws:iam:us-east-1:000000000000:stream/terraform-kinesis-test"
}

variable "s3_role_arn" {
  type        = string
  description = "The IAM role for S3 (a fake one for Localstack)."
  default = "arn:aws:iam:us-east-1:000000000000:stream/terraform-kinesis-test"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name that the S3 bucket will have"
  default = "tf-test-bucket"
}