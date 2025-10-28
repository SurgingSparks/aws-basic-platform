locals {
  name_prefix = "${var.project}-${var.environment}"

  names = {
    db_security_group = "${local.name_prefix}-sg-db"
    db_subnet_group   = "${local.name_prefix}-db-subnet-group"
    db_instance       = "${local.name_prefix}-db"
  }
}

