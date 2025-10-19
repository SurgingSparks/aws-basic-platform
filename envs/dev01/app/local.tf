locals {
  name_prefix = "${var.project}-${var.environment}"

  names = {
    sg_public_ssh = "${local.name_prefix}-sg-public-ssh"
    ec2_public    = "${local.name_prefix}-ec2-public-test"
  }
}
