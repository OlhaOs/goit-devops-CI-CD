output "db_endpoint" {
  description = "Endpoint створеної RDS бази (standalone або Aurora)."
  value       = try(aws_db_instance.standard[0].endpoint, aws_rds_cluster.aurora[0].endpoint)
}

output "db_security_group_id" {
  description = "ID security group, яка використовується для доступу до RDS."
  value       = aws_security_group.rds.id
}
output "rds_hostname" {
  description = "The address of the RDS instance"
  value       = try(aws_db_instance.standard[0].address, aws_rds_cluster.aurora[0].endpoint, "")
}