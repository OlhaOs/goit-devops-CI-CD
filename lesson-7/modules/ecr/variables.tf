variable "ecr_name" {
  type        = string
  description = "Назва ECR репозиторію"
}

variable "scan_on_push" {
  description = "Вмикає сканування на push"
  type        = bool
  default     = true
}
