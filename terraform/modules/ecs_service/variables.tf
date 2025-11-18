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

variable "db_url_ssm_arn" {
  description = "SSM Parameter ARN containing the DATABASE_URL value"
  type        = string
}

variable "redis_url_ssm_arn" {
  description = "SSM Parameter ARN containing the REDIS_URL value"
  type        = string
}

variable "redis_collab_url_ssm_arn" {
  description = "SSM Parameter ARN containing the REDIS_COLLABORATION_URL value"
  type        = string
}

variable "secret_key_ssm_arn" {
  description = "SSM Parameter ARN containing the SECRET_KEY value"
  type        = string
}

variable "utils_secret_ssm_arn" {
  description = "SSM Parameter ARN containing the UTILS_SECRET value"
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain logs in CloudWatch"
  type        = number
}

variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks (containers) that should run in the service"
  type        = number
}

variable "health_check_grace_period" {
  description = "The amount of time (in seconds) to ignore failing load balancer health checks at startup"
  type        = number
}

variable "ecs_max_capacity" {
  description = "Maximum number of ECS tasks allowed for autoscaling"
  type        = number
}

variable "ecs_min_capacity" {
  description = "Minimum number of ECS tasks allowed for autoscaling"
  type        = number
}

variable "ecs_target_value" {
  description = "Target memory utilization percentage for ECS autoscaling"
  type        = number
}

