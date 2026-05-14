variable "name" {
  description = "Назва для бази даних, кластера або пов'язаних ресурсів (використовується як префікс або тег)"
  type        = string
}

variable "engine" {
  description = "Тип двигуна бази даних для поодинокого інстансу RDS (наприклад, postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "engine_cluster" {
  description = "Тип двигуна бази даних для кластера Aurora"
  type        = string
  default     = "aurora-postgresql"
}

variable "aurora_replica_count" {
  description = "Кількість інстансів-реплік для розгортання в кластері Aurora"
  type        = number
  default     = 1
}

variable "engine_version" {
  description = "Версія двигуна бази даних для RDS інстансу"
  type        = string
  default     = "15"
}

variable "instance_class" {
  description = "Тип інстансу бази даних (обчислювальні потужності та пам'ять)"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Обсяг дискового простору, що виділяється для бази даних (в гігабайтах)"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Назва початкової бази даних, яка буде створена при ініціалізації"
  type        = string
}

variable "username" {
  description = "Ім'я головного користувача (admin) для доступу до бази даних"
  type        = string
}

variable "password" {
  description = "Пароль для головного користувача бази даних (маркований як чутливий)"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "Ідентифікатор VPC, в якій буде розгорнута інфраструктура бази даних"
  type        = string
}

variable "subnet_private_ids" {
  description = "Список ідентифікаторів приватних підмереж для групи субнетів бази даних"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Визначає, чи буде база даних мати публічну IP-адресу та доступ з інтернету"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Чи створювати базу даних у декількох зонах доступності для високої відмовостійкості"
  type        = bool
  default     = false
}

variable "parameters" {
  description = "Мапа кастомних параметрів конфігурації для двигуна бази даних"
  type        = map(string)
  default     = {
    "max_connections" = "100"
    "log_statement"   = "all"
  }
}

variable "use_aurora" {
  description = "Прапорець, що визначає, чи розгортати кластер Aurora замість стандартного RDS"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Кількість днів, протягом яких зберігаються автоматичні резервні копії"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Мапа тегів для маркування ресурсів AWS"
  type        = map(string)
  default     = {}
}

variable "parameter_group_family_aurora" {
  description = "Сімейство групи параметрів для кластера Aurora"
  type        = string
  default     = "aurora-postgresql15"
}

variable "engine_version_cluster" {
  description = "Конкретна версія двигуна для кластера Aurora"
  type        = string
  default     = "15.4"
}

variable "parameter_group_family_rds" {
  description = "Сімейство групи параметрів для стандартного інстансу RDS"
  type        = string
  default     = "postgres15"
}