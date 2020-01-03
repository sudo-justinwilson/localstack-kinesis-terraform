output "localstack_container_ip_addr" {
  value = module.localstack.container_ip_addr
}

output "kinesis_firehose_arn" {
  value       = module.kinesis.kinesis_firehose_arn
  description = "The ARN of the Kinesis firehose instance."
}

output "s3_bucket_arn" {
  # create a dependency for the S3 bucket on the localstack container:
  depends_on  = [
    localstack_container_ip_addr,
  ]
  value       = module.kinesis.aws_s3_bucket_arn
  description = "The ARN of the S3 bucket."
}


output "kinesis_stream_id" {
  value       = module.kinesis.test_terraform_stream
  description = "The ID of the test_terraform_stream and has a dependency on the localstack Docker container."
  depends_on  = [
    localstack_container_ip_addr,
  ]
}

output "random_container_ip_addr" {
  value = module.docker.random_container_ip_addr
  description = "The network details of the random Docker container, which can only be made once the kinesis stream is available, so it can send the random data to the kinesis stream."
  depends_on  = [
    kinesis_stream_id,
  ]
}