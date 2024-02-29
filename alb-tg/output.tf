output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.my-aws-alb.dns_name
}

output "zone_id" {
  description = "Alb hosted zone id"
  value = aws_lb.my-aws-alb.zone_id
}

output "target_group_arn" {
  description = "ARN of the target group."
  value       = aws_lb_target_group.my-target-group.arn
}

output "security_group_id" {
  description = "ID of the security group for the ALB."
  value       = aws_security_group.my-alb-sg.id
}

output "aws_lb_arn" {
  description = "ARN of LoadBalancer"
  value = aws_lb.my-aws-alb.arn
}