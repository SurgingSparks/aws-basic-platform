# ---- Security group: allow PostgreSQL from within the VPC ----
resource "aws_security_group" "db" {
  name        = local.names.db_security_group
  description = "Allow PostgreSQL access from within the VPC"
  vpc_id      = local.dev01_vpc_id

  ingress {
    description = "PostgreSQL from VPC"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = [local.dev01_vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = local.names.db_security_group }
}

# ---- DB subnet group in the private subnet ----
resource "aws_db_subnet_group" "db" {
  name        = local.names.db_subnet_group
  description = "Private subnet for the dev01 database"
  subnet_ids  = [local.dev01_private_subnet_id]

  tags = {
    Name = local.names.db_subnet_group
  }
}

# ---- Generated master password ----
resource "random_password" "db_master" {
  length  = 20
  special = false
}

# ---- PostgreSQL instance (DEV ONLY) ----
resource "aws_db_instance" "postgres" {
  identifier                 = local.names.db_instance
  engine                     = var.db_engine
  engine_version             = var.db_engine_version
  instance_class             = var.db_instance_class
  allocated_storage          = var.db_allocated_storage_gib
  storage_type               = var.db_storage_type
  db_name                    = var.db_name
  username                   = var.db_username
  password                   = random_password.db_master.result
  port                       = var.db_port
  db_subnet_group_name       = aws_db_subnet_group.db.name
  vpc_security_group_ids     = [aws_security_group.db.id]
  publicly_accessible        = false
  backup_retention_period    = var.db_backup_retention_days
  multi_az                   = var.db_multi_az
  deletion_protection        = var.db_deletion_protection
  skip_final_snapshot        = var.db_skip_final_snapshot
  apply_immediately          = true
  auto_minor_version_upgrade = true

  tags = {
    Name = local.names.db_instance
  }
}

