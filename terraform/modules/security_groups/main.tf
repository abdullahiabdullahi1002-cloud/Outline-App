# Security Group for ECS app
resource "aws_security_group" "ecs_sg" {
  vpc_id                 = var.vpc_id
  name                   = "${var.project_name}-sg-ecs"
  description            = "Security group for ecs app"
  revoke_rules_on_delete = true
}
# ECS app Security Group Rules - INBOUND
resource "aws_security_group_rule" "ecs_alb_ingress" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "TCP"
  description              = "Allow inbound traffic from ALB"
  security_group_id        = aws_security_group.ecs_sg.id
  source_security_group_id = aws_security_group.alb_sg.id
}
# ECS app Security Group Rules - OUTBOUND
resource "aws_security_group_rule" "ecs_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from ECS"
  security_group_id = aws_security_group.ecs_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
# Security Group for alb
resource "aws_security_group" "alb_sg" {
  vpc_id                 = var.vpc_id
  name                   = "${var.project_name}-sg-alb"
  description            = "Security group for alb"
  revoke_rules_on_delete = true
}
# Alb Security Group Rules - INBOUND
resource "aws_security_group_rule" "alb_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  description       = "Allow http inbound traffic from internet"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
# Alb Security Group Rules - INBOUND
resource "aws_security_group_rule" "alb_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  description       = "Allow https inbound traffic from internet"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
# Alb Security Group Rules - OUTBOUND
resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from alb"
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
# Security Group for RDS 
resource "aws_security_group" "rds-sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow PostgreSQL traffic from ECS tasks"
  vpc_id      = var.vpc_id
}
# RDS Security Group Rules - INBOUND
resource "aws_security_group_rule" "rds_ingress_from_ecs" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  description              = "Allow ECS tasks to connect to RDS"
  security_group_id        = aws_security_group.rds-sg.id
  source_security_group_id = aws_security_group.ecs_sg.id
}
# RDS Security Group Rules - OUTBOUND
resource "aws_security_group_rule" "rds_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from RDS"
  security_group_id = aws_security_group.rds-sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Redis Security Group
resource "aws_security_group" "redis_sg" {
  name        = "${var.project_name}-sg-redis"
  description = "Allow Redis access from ECS tasks"
  vpc_id      = var.vpc_id
}
# Redis  Security Group Rules - INBOUND
resource "aws_security_group_rule" "redis_ingress_from_ecs" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  description              = "Allow ECS tasks to connect to Redis"
  security_group_id        = aws_security_group.redis_sg.id
  source_security_group_id = aws_security_group.ecs_sg.id
}
# Redis  Security Group Rules - OUTBOUND
resource "aws_security_group_rule" "redis_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.redis_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
