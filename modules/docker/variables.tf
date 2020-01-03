variable "stream_name" {
  type        = string
  description = "The kinesis stream name"
  #depends_on = [aws_kinesis_stream.test_terraform_stream]
  default = "terraform-kinesis-firehose-test-stream"
}

variable "path" {
  type        = string
  description = "The path to the current directory"
  #default = "/home/justinwilson/workspaces/git/localstack-kinesis-terraform/modules/docker"
  default = "/home/justinwilson/workspaces/git/localstack-kinesis-terraform_old/modules/docker"
}
