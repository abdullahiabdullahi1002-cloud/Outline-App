# Subnet Group
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name        = "${var.project_name}-redis-subnet-group"
  description = "Subnet group for Redis ElastiCache"
  subnet_ids  = [var.private_subnet_1_id, var.private_subnet_2_id]
}


resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.project_name}-redis-cluster"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  port                 = 6379
  parameter_group_name = "default.redis7"
  engine_version       = "7.0"
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [var.redis_sg_id]

  tags = {
    Name = "${var.project_name}-redis"
  }
}

