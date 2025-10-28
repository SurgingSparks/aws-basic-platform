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
# --------------- Instance settings ---------------
variable "instance_type" {
  description = "Instance size for the test server"
  type        = string
  default     = "t3.micro"
}

variable "ssh_key_name" {
  description = "Existing EC2 key pair name"
  type        = string
  default     = "general-server-key"
}

variable "my_ip_cidr" {
  description = "Your public IP in CIDR form for SSH"
  type        = string
  default     = "115.70.50.57/32"
}

variable "ami_id" {
  description = "Amazon Machine Image: Amazon Linux 2023 kernel-6.1 AMI"
  type        = string
  default     = "ami-075924b436aa32cd4"
}
# --------------- storage settings ---------------
variable "data_volume_size_gib" { 
  type = number 
  default = 10 
}   
variable "data_volume_type"     { 
  type = string  
  default = "gp3" 
}
variable "kms_key_id"           { 
  type = string  
  default = null 
} 
# --------------- Vault ---------------
variable "backup_vault_force_destroy" {
  description = "Allow destroying the vault even if it contains recovery points (DEV ONLY!)."
  type        = bool
  default     = true
}

