locals {
  name_prefix = "${var.project}-${var.environment}"

  names = {
    vol_app       = "${local.name_prefix}-vol-serv01"
    sg_public_ssh = "${local.name_prefix}-sg-public-ssh"
    srv01    = "${local.name_prefix}-srv01"
  }
}
