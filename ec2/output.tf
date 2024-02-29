output "Private_instance_id" {
  value       = aws_instance.Private_ec2.id
}

output "Public_instance_id" {
  value       = aws_instance.Public_ec2.id
}

output "ec2instance" {
  value = aws_instance.Public_ec2.public_ip
}