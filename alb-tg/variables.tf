variable "vpc_id" {
  description = "ID of the VPC where the resources will be created."
}

variable "subnet1" {
  description = "ID of the first subnet where the ALB will be deployed."
}

variable "subnet2" {
  description = "ID of the second subnet where the ALB will be deployed."
}

variable "instance1_id" {
  description = "ID of the first target instance to attach to the target group."
}

variable "alb_sg" {
  description = "Security group for Loadbalancer"
}
variable "target_group" {
  description = "Target group name"
}

variable "alb" {
  description = "LoadBalancer name"
}