
 variable "instance_ami" {
  description = "AMI ID for the private EC2 instance"
}

variable "instance_type" {
  description = "Instance type for the private EC2 instance"
}

variable "key_name" {
  description = "Key for accessing EC2"
}

variable "vpc" {
  description = "Vpc for Security group"
}

variable "secgroupname" {
  description = "Security group name"
}

#private instance
variable "priv_instance_name" {
  description = "Name for the private EC2 instance"
}

variable "private_subnet_id" {
  description = "Subnet for EC2"
}

# public instance

variable "pub_instance_name" {
  description = "Name for the public EC2 instance"
}

variable "public_subnet_id" {
  description = "Subnet for EC2"
}

