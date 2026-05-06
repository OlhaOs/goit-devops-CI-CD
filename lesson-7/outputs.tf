# Виведення URL репозиторію ECR через модуль
output "ecr_repository_url" {
  description = "URL репозиторію ECR"
  value       = module.ecr.ecr_repository_url
}

# Виведення ARN репозиторію ECR через модуль
output "ecr_repository_arn" {
  description = "ARN репозиторію ECR"
  value       = module.ecr.ecr_repository_arn
}

# Виведення імені репозиторію ECR через модуль
output "ecr_repository_name" {
  description = "Ім'я репозиторію ECR"
  value       = module.ecr.ecr_repository_name
}

# Виведення registry ID через модуль
output "ecr_registry_id" {
  description = "ID реєстру ECR"
  value       = module.ecr.ecr_registry_id
}
output "vpc_id" {
  description = "ID створеної VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "ID публічних підмереж"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "ID приватних підмереж"
  value       = module.vpc.private_subnets
}

output "s3_bucket_url" {
  description = "URL S3 бакета для стейтів"
  value       = module.s3_backend.s3_bucket_url
}

output "dynamodb_table_name" {
  description = "Ім'я DynamoDB таблиці для блокування"
  value       = module.s3_backend.dynamodb_table_name
}