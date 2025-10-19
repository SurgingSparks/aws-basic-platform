output "public_test_ip" {
  value = aws_instance.public_test.public_ip
}

output "public_test_instance_id" {
  value = aws_instance.public_test.id
}
