output "srv01_instance_id" {
  value = aws_instance.srv01.id
}

output "srv01_public_ip" {
  value = aws_instance.srv01.public_ip
}

output "srv02_instance_id" {
  value = aws_instance.srv02.id
}

output "srv02_private_ip" {
  value = aws_instance.srv02.private_ip
}

output "backup_vault_name" {
  value = aws_backup_vault.dev01vault.name
}

output "backup_vault_arn" {
  value = aws_backup_vault.dev01vault.arn
}
