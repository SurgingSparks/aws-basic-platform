locals {
  # prefix for tagging e.g. "aws-env-dev01"
  name_prefix = "${var.project}-${var.environment}"

  # Standard Name tags per resource
  names = {
    vpc           = "${local.name_prefix}-vpc"
    subnet_public = "${local.name_prefix}-subnet-public"
    subnet_priv   = "${local.name_prefix}-subnet-private"
    igw           = "${local.name_prefix}-igw"
    rt_public     = "${local.name_prefix}-rt-public"
    nat_eip       = "${local.name_prefix}-nat-eip"
    nat_gw        = "${local.name_prefix}-nat"
    rt_private    = "${local.name_prefix}-rt-private"
  }
}