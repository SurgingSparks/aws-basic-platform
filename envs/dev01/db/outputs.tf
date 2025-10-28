output "db_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "db_port" {
  value = aws_db_instance.postgres.port
}

output "db_identifier" {
  value = aws_db_instance.postgres.id
}

output "db_security_group_id" {
  value = aws_security_group.db.id
}

output "db_master_password" {
  value     = random_password.db_master.result
  sensitive = true
}

