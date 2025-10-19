# ---- Security group: SSH from your IP only, egress all ----
resource "aws_security_group" "public_ssh" {
  name        = local.names.sg_public_ssh
  description = "Allow SSH from my IP; egress all"
  vpc_id      = local.dev01_vpc_id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = local.names.sg_public_ssh }
}

# ---- EC2 instance in the PUBLIC subnet ----
resource "aws_instance" "public_test" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = local.dev01_public_subnet_id
  vpc_security_group_ids = [aws_security_group.public_ssh.id]
  key_name               = var.ssh_key_name

  # keep root minimal & auto-clean
  root_block_device {
    delete_on_termination = true
  }

  tags = { Name = local.names.ec2_public }

  user_data = <<-EOF
              #!/bin/bash
              set -euxo pipefail
              dnf -y update
              dnf -y install curl
              echo "Hello from $(hostname) in ${var.environment}" > /etc/motd
              EOF
}
