output "security_group_ecs_ids" {
  description = "Security group IDs for ECS tasks"
  value       = [aws_security_group.ecs_sg.id]
}

output "security_group_alb_ids" {
  description = "Security group IDs for ALB"
  value       = [aws_security_group.alb_sg.id]
}

output "rds_sg_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds-sg.id
}

output "redis_sg_id" {
  description = "Redis Security Group ID"
  value       = aws_security_group.redis_sg.id
}
