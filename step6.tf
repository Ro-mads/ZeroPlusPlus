# WebServer


provider "aws" {}



resource "aws_instance" "WebServer" {
  ami                    = "ami-070b208e993b59cea"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.WebServer.id]

  tags = {
    Name  = "WebServer"
    Owner = "Romads"

  }

  depends_on = [aws_instance.DataServer, aws_instance.AppServer]

}

resource "aws_instance" "AppServer" {
  ami                    = "ami-070b208e993b59cea"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.WebServer.id]

  tags = {
    Name  = "ApplicationServer"
    Owner = "Romads"
  }

  depends_on = [aws_instance.DataServer]

}


resource "aws_instance" "DataServer" {
  ami                    = "ami-070b208e993b59cea"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.WebServer.id]

  tags = {
    Name  = "DattbaseServer"
    Owner = "Romads"

  }
}

resource "aws_security_group" "WebServer" {
  name        = "WebServer Security group"
  description = "First SecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name  = "WebServer_SecurityGroup"
    Owner = "Romads"
  }

}
