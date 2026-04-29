variable "bucket_name" {
  description = "Назва S3 бакета для зберігання стейту"
  type        = string
}

variable "table_name" {
  description = "Назва DynamoDB таблиці для блокувань"
  type        = string
}