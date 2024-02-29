output "asg_security_group_id" {
  description = "ID of the ASG Security Group."
  value       = aws_security_group.asg_security_group.id
}

output "launch_template_id" {
  description = "ID of the Launch Template."
  value       = aws_launch_template.launch_template.id
}

output "auto_scaling_group_name" {
  description = "Name of the Auto Scaling Group."
  value       = aws_autoscaling_group.auto_scaling_group.name
}

output "auto_scaling_group_arn" {
  description = "ARN of the Auto Scaling Group."
  value       = aws_autoscaling_group.auto_scaling_group.arn
}
