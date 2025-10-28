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

# --------------- Database settings ---------------
variable "db_engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "15.4"
}

variable "db_instance_class" {
  description = "Instance size for the database"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage_gib" {
  description = "Allocated storage size for the database"
  type        = number
  default     = 20
}

variable "db_storage_type" {
  description = "Storage type for the database"
  type        = string
  default     = "gp3"
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
  default     = "app_admin"
}

variable "db_port" {
  description = "Port the database listens on"
  type        = number
  default     = 5432
}

variable "db_backup_retention_days" {
  description = "Backup retention period in days"
  type        = number
  default     = 1
}

variable "db_multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
  default     = false
}

variable "db_deletion_protection" {
  description = "Protect the instance from deletion"
  type        = bool
  default     = false
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot on destroy (DEV ONLY)"
  type        = bool
  default     = true
}

