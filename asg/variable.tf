variable "asg_sg_name" {
  description = "Name of the ASG Security Group."
}

variable "vpc_id" {
  description = "VPC Id for Security group"
}

variable "launch_template_name" {
  description = "Name of the Launch Template."
}

variable "ami" {
  description = "ID of the Amazon Machine Image (AMI) to use for EC2 instances."
}

variable "instance_type" {
  description = "Type of EC2 instances to launch."
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group."
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group."
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group."
}

variable "private_subnets" {
  description= "VPC zone identifier"
}