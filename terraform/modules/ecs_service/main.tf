resource "aws_ecs_cluster" "outline" {
  name = "${var.project_name}-cluster"
}

resource "aws_cloudwatch_log_group" "outline" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = var.log_retention_days

  tags = {
    Name = "${var.project_name}-log-group"
  }
}

# Task Definition

resource "aws_ecs_task_definition" "outline" {
  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = var.ecs_task_execution_role

  container_definitions = jsonencode([
    {
      name      = var.project_name
      image     = var.ecr_image_url
      cpu       = var.task_cpu
      memory    = var.task_memory
      essential = true

      environment = [
        {
          name  = "URL"
          value = "https://${var.domain_name}"
        },
        {
          name  = "PORT"
          value = tostring(var.containerPort)
        }
      ]

      secrets = [
        {
          name      = "DATABASE_URL"
          valueFrom = var.db_url_ssm_arn
        },
        {
          name      = "REDIS_URL"
          valueFrom = var.redis_url_ssm_arn
        },
        {
          name      = "REDIS_COLLABORATION_URL"
          valueFrom = var.redis_collab_url_ssm_arn
        },
        {
          name      = "SECRET_KEY"
          valueFrom = var.secret_key_ssm_arn
        },
        {
          name      = "UTILS_SECRET"
          valueFrom = var.utils_secret_ssm_arn
        }
      ]

      portMappings = [
        {
          containerPort = var.containerPort
          hostPort      = var.containerPort
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/${var.project_name}"
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "outline" {
  name                               = "${var.project_name}-service"
  cluster                            = aws_ecs_cluster.outline.id
  task_definition                    = aws_ecs_task_definition.outline.arn
  propagate_tags                     = "TASK_DEFINITION"
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  launch_type                        = "FARGATE"
  health_check_grace_period_seconds  = var.health_check_grace_period


  network_configuration {
    subnets          = [var.private_subnet_1_id, var.private_subnet_2_id]
    security_groups  = var.security_group_ecs_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.project_name
    container_port   = var.containerPort
  }
  depends_on = [
    aws_ecs_task_definition.outline,
    var.alb_https_listener_arn
  ]
}

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.ecs_max_capacity
  min_capacity       = var.ecs_min_capacity
  resource_id        = "service/${aws_ecs_cluster.outline.name}/${aws_ecs_service.outline.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "ecs-scale-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value = var.ecs_target_value
  }
}
