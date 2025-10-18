resource "aws_lb" "outline-lb" {
  name                       = "${var.project_name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.security_group_alb_ids
  subnets                    = [var.public_subnet_1_id, var.public_subnet_2_id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "outline-lb" {
  name        = "${var.project_name}-alb-tg"
  target_type = "ip"
  port        = var.containerPort
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200-399"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 10
    interval            = 30
  }
}

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.outline-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.outline-lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.outline-lb.arn
  }
}
