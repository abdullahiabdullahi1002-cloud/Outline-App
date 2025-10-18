resource "aws_ssm_parameter" "db_url" {
  name  = "/${var.project_name}/DATABASE_URL"
  type  = "SecureString"
  value = "postgres://${var.db_username}:${var.db_password}@${var.rds_endpoint}:5432/${var.project_name}"
}

resource "aws_ssm_parameter" "redis_url" {
  name  = "/${var.project_name}/REDIS_URL"
  type  = "String"
  value = "redis://${var.redis_endpoint}:6379"
}

resource "aws_ssm_parameter" "redis_collab_url" {
  name  = "/${var.project_name}/REDIS_COLLABORATION_URL"
  type  = "String"
  value = "redis://${var.redis_endpoint}:6379"
}

resource "aws_ssm_parameter" "secret_key" {
  name  = "/${var.project_name}/SECRET_KEY"
  type  = "SecureString"
  value = var.secret_key
}

resource "aws_ssm_parameter" "utils_secret" {
  name  = "/${var.project_name}/UTILS_SECRET"
  type  = "SecureString"
  value = var.utils_secret
}
