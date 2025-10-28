# ---------------- VPC ----------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = local.names.vpc
  }
}

# --------------- Subnets ---------------
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = {
    Name = local.names.subnet_public
    Tier = "public"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.az

  tags = {
    Name = local.names.subnet_priv
    Tier = "private"
  }
}

# ---------------- Internet Gateway ----------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = local.names.igw
  }
}

# ------------- Public Route Table (+ default route) -------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = local.names.rt_public
  }
}

# ------------- public route to internet -------------
resource "aws_route" "public_inet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# ------------- Link public route to public subnet -------------
resource "aws_route_table_association" "pub_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
# ------------- Private route -------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = local.names.rt_private
  }
}
# ------------- Link private route to private subnet -------------
resource "aws_route_table_association" "priv_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
