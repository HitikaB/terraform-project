variable "aws_region" {
  description = "AWS region for creating the EFS file system."
  default     = "us-east-1" 
}

variable "efs_name" {
  description = "Name for the EFS file system."
  default     = "Myfilesystem"
}

variable "subnet_id" {
  description = "ID of the subnet in which to create the EFS mount target."
  
}