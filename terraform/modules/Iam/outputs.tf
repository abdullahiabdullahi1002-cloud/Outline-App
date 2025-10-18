output "ecs_task_execution_role" {
  description = "The ARN of the ECS task execution role"
  value       = aws_iam_role.test_role.arn
}
