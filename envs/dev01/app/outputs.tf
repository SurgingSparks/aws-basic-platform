output "public_test_ip" {
  value = aws_instance.srv01.public_ip
}
output "srv01_instance_id" {
  value = aws_instance.srv01.id
}
output "backup_vault_name" { 
  value = aws_backup_vault.dev01vault.name 
}
output "backup_vault_arn"  { 
  value = aws_backup_vault.dev01vault.arn 
}
