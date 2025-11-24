variable "project_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_1_cidr" {
  type = string
}

variable "public_subnet_2_cidr" {
  type = string
}

variable "public_subnet_1_az" {
  type = string
}

variable "public_subnet_2_az" {
  type = string
}

variable "private_subnet_1_cidr" {
  type = string
}

variable "private_subnet_2_cidr" {
  type = string
}

variable "private_subnet_1_az" {
  type = string
}

variable "private_subnet_2_az" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "record_name" {
  type = string
}

variable "ecr_image_url" {
  type = string
}

variable "task_cpu" {
  type = number
}

variable "task_memory" {
  type = number
}

variable "containerPort" {
  type = number
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  type = number
}

variable "ecs_task_deployment_maximum_percent" {
  type = number
}

variable "admin_user_arn" {
  type        = string
  sensitive   = true
  description = "IAM admin user ARN"
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "RDS database password"
}

variable "rds_endpoint" {
  type        = string
  sensitive   = true
  description = "RDS endpoint"
}

variable "redis_endpoint" {
  type        = string
  sensitive   = true
  description = "Redis cluster endpoint"
}

variable "secret_key" {
  type        = string
  sensitive   = true
  description = "Application secret key"
}

variable "utils_secret" {
  type        = string
  sensitive   = true
  description = "Application utility secret"
}

variable "log_retention_days" {
  type = number
}

variable "desired_count" {
  type = number
}

variable "health_check_grace_period" {
  type = number
}

variable "ecs_max_capacity" {
  type = number
}

variable "ecs_min_capacity" {
  type = number
}

variable "ecs_target_value" {
  type = number
}
