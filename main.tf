terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "AWS-instance" {
  name        = "team15_ssh"
  description = "grant ssh permission"

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    self = true
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "AWS-instance" {
  ami = "ami-00daffb0d753df675"
  instance_type = "t2.micro"
  key_name = "team15_dependencies"
  vpc_security_group_ids = [aws_security_group.AWS-instance.id]
  tags = {
    Name = "Team15"
  }

    connection {
      type        = "ssh"
      private_key =  file("team15_dependencies.pem")
      user        = "ubuntu"
      timeout     = "1m"
      host = self.public_ip
    }
} 

resource "aws_eip" "EIP" {
  name = "team15_elastic_ip"
  instance = aws_instance.AWS-instance.id
  vpc = true
}