output "target_group_arn" {
  description = "The ARN of the ALB target group"
  value       = aws_lb_target_group.outline-lb.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.outline-lb.dns_name
}

output "alb_zone_id" {
  description = "The DNS name of the ALB"
  value       = aws_lb.outline-lb.zone_id
}

output "alb_https_listener_arn" {
  description = "ARN of the HTTPS listener for the ALB"
  value       = aws_lb_listener.alb_https_listener.arn
}
