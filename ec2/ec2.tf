
resource "aws_security_group" "ec2-sg" {
  name = var.secgroupname
  description = var.secgroupname
  vpc_id = var.vpc

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "Private_ec2" {
  #count = 2
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  associate_public_ip_address = false
  subnet_id     = var.private_subnet_id

  vpc_security_group_ids = [
    aws_security_group.ec2-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name =var.priv_instance_name
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.ec2-sg]
  
}

resource "aws_instance" "Public_ec2" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  associate_public_ip_address = true
  subnet_id     = var.public_subnet_id

  vpc_security_group_ids = [
    aws_security_group.ec2-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name =var.priv_instance_name
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.ec2-sg ]
  
}

