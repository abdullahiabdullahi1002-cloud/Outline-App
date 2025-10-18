variable "project_name" {
  type = string
}

variable "vpc_id" {
  description = "The VPC ID where the ALB will be deployed"
  type        = string
}

variable "public_subnet_1_id" {
  description = "The subnet ID 1 where the ALB will be deployed"
  type        = string
}

variable "public_subnet_2_id" {
  description = "The subnet ID 2 where the ALB will be deployed"
  type        = string
}

variable "security_group_alb_ids" {
  description = "Security groups to associate with the ALB"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate"
  type        = string
}

variable "containerPort" {
  description = "The port on which the container listens"
  type        = number
}

