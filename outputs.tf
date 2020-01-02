output "kinesis_stream_arn" {
  value       = aws_kinesis_stream.test_terraform_stream.arn
  description = "The ARN of the test_terraform_stream."
}

output "kinesis_stream_name" {
  value       = aws_kinesis_stream.test_terraform_stream.name
  description = "The name of the test_terraform_stream."
}

output "kinesis_stream_id" {
  value       = aws_kinesis_stream.test_terraform_stream.id
  description = "The ID of the test_terraform_stream."
}
output "kinesis_stream_shard_count" {
  value       = aws_kinesis_stream.test_terraform_stream.shard_count
  description = "The shard count of the test_terraform_stream."
}

output "kinesis_firehose_arn" {
  #depends_on  = [docker_container.localstack]
  value       = aws_kinesis_firehose_delivery_stream.test_stream.arn
  description = "The ARN of the Kinesis firehose instance."
}

output "s3_bucket_arn" {
  # attempt to fix localstack dependency:
  depends_on  = [docker_container.localstack]
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket."
}