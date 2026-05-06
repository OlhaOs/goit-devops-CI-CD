output "s3_bucket_url" {
  value       = aws_s3_bucket.terraform_state.bucket_domain_name
  description = "The URL of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "Назва таблиці DynamoDB"
}
