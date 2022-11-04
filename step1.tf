# WebServer


provider "aws" {}


resource "aws_instance" "WebServer" {
  ami                    = "ami-070b208e993b59cea"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.WebServer.id]
  user_data              = <<EOF
#!bin/bash
yum -y update
yum -y install httpd
myip=`cutl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer Start: $myip</h2><br>All The Way UP!UP!UP!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

  tags = {
    Name  = "WebServer"
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
