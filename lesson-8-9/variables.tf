variable "jenkins_admin_password" {
  description = "Jenkins admin password"
  type        = string
  sensitive   = true
}

variable "github_username" {
  description = "GitHub username"
  type        = string
}

variable "github_pat" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

# Для Jenkins (код застосунку)
variable "github_url" {
  description = "GitHub repository URL for the Django application"
  type        = string
}

variable "github_main_branch" {
  description = "Main branch for Django app"
  type        = string
  default     = "main"
}

# Для Argo CD (інфраструктура та чарти)
variable "github_tf_url" {
  description = "GitHub repository URL for Infrastructure/Charts"
  type        = string
}

variable "github_tf_branch" {
  description = "Branch for Infrastructure/Charts"
  type        = string
}

variable "helm_chart_path" {
  description = "Path to the Helm chart inside the repository"
  type        = string
}