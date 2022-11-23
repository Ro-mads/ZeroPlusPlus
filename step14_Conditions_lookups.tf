provider "aws" {}

variable "env" {
  default = "prod"
}

variable "prod_owner" {
  default = "Romads"
}

variable "noprod_owner" {
  default = "sek"
}

variable "ec2_size" {
  default = {
    "prod" = "t3.medium"
    "dev" = "t3.micro"
    "staging" = "t2.small"
  }
}

variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev" = ["80", "443", "8080", "22"]
  }
}
resource "aws_instance" "webserver1" {
  ami           = "ami-070b208e993b59cea"
  instance_type = lookup(var.ec2, var.env)

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }

}


resource "aws_instance" "webserver" {
  ami           = "ami-070b208e993b59cea"
  //instance_type = var.env == "prod" ? "t2.large" : "t2.micro"
  instance_type = var.env == "prod" ? var.ec2_size["prod"] : var.ec2_size["dev"]
  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }

}

resource "aws_instance" "dev_bastion" {
  count = var.env = "dev" ? 1 : 0
  ami           = "ami-070b208e993b59cea"
  instance_type = t2.micro

  tags = {
    Name = "Bastion Server"
  }

}

resource "aws_security_group" "WebServer" {
  name        = "WebServer Security group"
  description = "First SecurityGroup"

  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.en)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "DynamicSecurityGroup"
    Owner = "Romads"
  }
}
