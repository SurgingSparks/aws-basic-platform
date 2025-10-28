# --------------- Default Tags ---------------
variable "project" {
  description = "Short project/system identifier"
  type        = string
  default     = "aws-env"
}

variable "environment" {
  description = "Environment identifier"
  type        = string
  default     = "dev01"
}
variable "owner" {
  description = "Owner tag value (email or team)"
  type        = string
  default     = "platform-team"
}

variable "cost_center" {
  description = "Cost center tag value"
  type        = string
  default     = "devops-lab"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}
# --------------- dev01 network ---------------
variable "vpc_cidr" {
  description = "VPC CIDR range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az" {
  description = "Single AZ to start with (expand later)"
  type        = string
  default     = "ap-southeast-2a"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet"
  type        = string
  default     = "10.0.1.0/24"
}

