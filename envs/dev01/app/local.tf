locals {
  name_prefix = "${var.project}-${var.environment}"

  names = {
    vol_app_public  = "${local.name_prefix}-vol-serv01"
    vol_app_private = "${local.name_prefix}-vol-serv02"
    sg_public_ssh   = "${local.name_prefix}-sg-public-ssh"
    srv01           = "${local.name_prefix}-srv01"
    srv02           = "${local.name_prefix}-srv02"
    backup_vault    = "${local.name_prefix}-backup-vault"
  }
}
