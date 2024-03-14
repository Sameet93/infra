output "password" {
  description = "password"
  value       = var.pass
  sensitive   = true
}
output "address" {
  description = "address"
  value       = aws_db_instance.postgres_db.address
}
output "vpcSecGroupIds" {
  description = "sg ids"
  value       = aws_db_instance.postgres_db.vpc_security_group_ids
}
