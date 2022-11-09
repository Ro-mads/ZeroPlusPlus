# WebServer


provider "aws" {}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.WebServer.id
}

resource "aws_instance" "WebServer" {
  ami                    = "ami-070b208e993b59cea"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.WebServer.id]
  user_data = templatefile("scritp_data.sh.tpl", {
    f_name = "Ro"
    l_name = "mads"
    names  = ["Valera", "Ilias", "Laura", "Djiga", "Julia", "GO"]
  })

  tags = {
    Name  = "WebServer"
    Owner = "Romads"
  }

  lifecycle {
    create_before_destroy = true
  }


  /*lifecycle {
    prevent_destroy = true #1
    ignore_changes  = ["ami", "user_data"] #2
  }*/


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
