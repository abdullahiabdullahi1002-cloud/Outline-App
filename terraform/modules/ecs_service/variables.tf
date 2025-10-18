variable "project_name" {
  type = string
}

variable "domain_name" {
  type        = string
  description = "The domain name for the ACM certificate"
}

variable "db_username" {
  description = "RDS username"
  type        = string
}

variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "private_subnet_1_id" {
  description = "The private subnet ID 1 where the ECS tasks will be deployed"
  type        = string
}

variable "private_subnet_2_id" {
  description = "The private subnet ID 2 where the ECS tasks will be deployed"
  type        = string
}

variable "security_group_ecs_ids" {
  description = "Security groups to associate with the ECS tasks"
  type        = list(string)
}

variable "ecs_task_execution_role" {
  description = "The ARN of the ECS task execution role"
  type        = string
}

variable "target_group_arn" {
  description = "The target group of arn alb"
  type        = string
}

variable "ecr_image_url" {
  description = "The URL of the ECR image to deploy"
  type        = string
}

variable "task_cpu" {
  description = "The CPU units for the ECS task"
  type        = number
}

variable "task_memory" {
  description = "The memory (in MiB) for the ECS task"
  type        = number
}

variable "containerPort" {
  description = "The port on which the container listens"
  type        = number
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  description = "The minimum healthy percent for the ECS service deployment"
  type        = number
}

variable "ecs_task_deployment_maximum_percent" {
  description = "The maximum percent for the ECS service deployment"
  type        = number
}

variable "alb_https_listener_arn" {
  description = "ARN of the HTTPS listener for the ALB"
  type        = string
}

variable "secret_key" {
  description = "The secret key used by Outline for encryption and signing"
  type        = string
  sensitive   = true
}

variable "utils_secret" {
  description = "A secret key used for utility functions (e.g., collaboration features)"
  type        = string
  sensitive   = true
}

variable "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  type        = string
}

variable "redis_endpoint" {
  description = "Endpoint of the ElastiCache Redis cluster"
  type        = string
}

variable "db_url_ssm_arn" {}
variable "redis_url_ssm_arn" {}
variable "redis_collab_url_ssm_arn" {}
variable "secret_key_ssm_arn" {}
variable "utils_secret_ssm_arn" {}


