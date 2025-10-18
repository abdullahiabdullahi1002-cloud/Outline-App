variable "project_name" {
  description = "Project name"
  type        = string
}

variable "private_subnet_1_id" {
  description = "Private subnet 1 ID"
  type        = string
}

variable "private_subnet_2_id" {
  description = "Private subnet 2 ID"
  type        = string
}

variable "redis_sg_id" {
  description = "Security Group ID for Redis (from the security module)"
  type        = string
}
