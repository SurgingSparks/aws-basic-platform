output "public_test_ip" {
  value = aws_instance.srv01.public_ip
}

output "srv01_instance_id" {
  value = aws_instance.srv01.id
}
