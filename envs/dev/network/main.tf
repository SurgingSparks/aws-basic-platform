module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "dev-vpc"
  cidr = "10.10.0.0/16"

  azs             = ["ap-southeast-2a", "ap-southeast-2b"]
  public_subnets  = ["10.10.10.0/24", "10.10.11.0/24"]
  private_subnets = ["10.10.20.0/24", "10.10.21.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  tags = { env = "dev" }
}
