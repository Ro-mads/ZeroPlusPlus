# WebServer


provider "aws" {}

resource "aws_security_group" "WebServer" {
  name        = "WebServer Security group"
  description = "First SecurityGroup"

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "1541", "9092"]
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
