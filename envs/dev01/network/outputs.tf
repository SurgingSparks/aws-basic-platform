output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "private_subnet_ids" {
  value = [aws_subnet.private.id]
}

output "name_prefix" {
  value = local.name_prefix
}

output "igw_id" { 
  value = aws_internet_gateway.igw.id 
}

output "public_rt_id" { 
  value = aws_route_table.public.id
}

