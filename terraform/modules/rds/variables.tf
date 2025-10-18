variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "db_username" {
  description = "RDS root user name"
  type        = string
  default     = "postgres"

}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "private_subnet_1_id" {
  description = "Private subnet 1 ID"
  type        = string
}

variable "private_subnet_2_id" {
  description = "Private subnet 2 ID"
  type        = string
}

variable "rds_sg_id" {
  description = "Security group ID that allows ECS to access RDS"
  type        = string
}
