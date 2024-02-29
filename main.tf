
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

#   backend "s3" {
#     bucket         = "tf-backend-hitika"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#   }
 }

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  shared_config_files      = ["/home/neosoft/.aws/config"]
  shared_credentials_files = ["/home/neosoft/.aws/credentials"]
}

# data "terraform_remote_state" "vpc" {
#   backend = "local"
#   config = {
#       path = "/home/neosoft/terraform-project/vpc/terraform.tfstate"
#     }
#   }

module "vpc" {
  source = "./vpc"
  region = "us-east-1"

vpc_cidr_block       = "10.0.0.0/16"
vpc_instance_tenancy = "default"
vpc_name             = "tf-vpc"
availability_zone_1 = "us-east-1a"
availability_zone_2 = "us-east-1b"
pub_subnet1_cidr    = "10.0.1.0/24"
pub_subnet1_name    = "tf-pub1-subnet"
pub_subnet2_cidr    = "10.0.3.0/24"
pub_subnet2_name    = "tf-pub2-subnet"
priv_subnet1_cidr   = "10.0.2.0/24"
priv_subnet1_name   = "tf-pri1-subnet"
priv_subnet2_cidr   = "10.0.4.0/24"
priv_subnet2_name   = "tf-pri2-subnet"
pub_route_table_name = "tf-pubroute"
priv_route_table_name = "tf-priroute"
}

module "rds" {
  source = "./rds"
  region                   = "us-east-1"
  db_instance_identifier   = "tf-db"
  rds_storage_type         = "gp2"
  allocated_storage        = 20
  db_username              = "admin"
  db_password              = "password"
  rds_publicly_accessible  = false
  security_group_name      = "rds-sg"
  security_group_cidr      = "0.0.0.0/0"
  rds_engine               = "mysql"
  rds_engine_version       = "8.0.28"
  rds_instance_class       = "db.t3.micro"
  rds_parameter_group_name = "default.mysql8.0"
  rds_skip_final_snapshot  = true
  rds_option_group_name    = "default:mysql-8-0"
  db_subnet_group          = [module.vpc.subnet03_id, module.vpc.subnet04_id]
  vpc_id                   = module.vpc.vpc_id
}

module "ec2" {
  source = "./ec2"
  priv_instance_name     = "Private-Instance"
  pub_instance_name      = "Private-Instance"
  instance_ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "terra"
  secgroupname           = "ec2-sg"
  vpc                    = module.vpc.vpc_id
  private_subnet_id      = module.vpc.subnet03_id
  public_subnet_id       = module.vpc.subnet01_id
}

module "alb" {
  source       = "./alb-tg"
  alb_sg       = "alb-sg"
  alb          = "alb-test"
  target_group = "tg-test"
  vpc_id       = module.vpc.vpc_id
  instance1_id = module.ec2.Private_instance_id
  subnet1      = module.vpc.subnet03_id
  subnet2      = module.vpc.subnet04_id
}

module "asg" {
  source = "./asg"
  asg_sg_name           = "asg-sg"
  launch_template_name  = "asg-template-test"
  ami                  = "ami-0fc5d935ebf8bc3bc"
  instance_type        = "t2.micro"
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_id = module.vpc.vpc_id
  private_subnets = [module.vpc.subnet03_id, module.vpc.subnet04_id]
}

module "my_cloudfront" {
  source = "./cdn"

  region                   = "us-east-1"
  cf_restriction_locations = ["US", "CA", "GB", "DE", "IN"]
  aliases                  = "cdntest.deltawing.live"
  origin_endpoint          = module.alb.alb_dns_name
  cert_arn                 = module.route53.certificate_arn
}

module "route53" {
  source = "./route53-acm"
  domain_name = "deltawing.live"
  ttl = 30
  record_type = "A"
  alb_dns_name = module.alb.alb_dns_name
  zone_id = module.alb.zone_id
}

module "efs" {
  source = "./efs"
  subnet_id = module.vpc.subnet03_id
  }

module "waf" {
  source = "./waf"
  aws_lb_arn = module.alb.aws_lb_arn
}

module "sns" {
  source = "./sns"
  sns_topic_name = "mysns"
  sns_topic_subscription_endpoint = "alfiya.zabir@neosoftmail.com"
  sns_topic_subscription_protocol = "email"
}

# module "my_ecr" {
#   source = "./ecr"

#   region = "us-east-1"
#   ecr    = "hadiya-backend"
# }

# module "ecs" {
#   source      = "./ecs-fargate"
#   vpc_id      = module.vpc.vpc_id
#   public_subnets = [module.vpc.subnet01_id, module.vpc.subnet02_id]
#   private_subnets = [module.vpc.subnet03_id, module.vpc.subnet04_id]
#   app_count   = 1
# }

