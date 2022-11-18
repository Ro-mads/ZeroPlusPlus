# Variables 


provider "aws" {
  //region = var.region
}



resource "aws_instance" "WebServer" {
  ami                    = "ami-070b208e993b59cea"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.WebServer.id]
  monitoring             = var.enable_detailed_monitoring
  /*user_data = templatefile("scritp_data.sh.tpl", {
    f_name = "Ro"
    l_name = "mads"
    names  = ["Valera", "Ilias", "Laura", "Djiga", "Julia", "GO"]
  }

  tags = {
    Name   = "WebServer"
    Owner  = "Romads"
    Region = var.region
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
  tags = var.common_tags
  //tags = merge(var.comon_tags, { Name = "${var.common_tags["beispiel1"]} beispiel2" })
  /*tags = {
    Name  = "WebServer_SecurityGroup"
    Owner = "Romads"
  }*/

}

/*variables.tf file

variable "region" {
  description = "Please Enter Region"
  //default = "ca-central-1"
}

variable "instance_type" {
  description = "Enter Instance Type"
  type        = string
  default     = "t3.micro"
}

/*variable "allow_ports" {
  description = "List of Ports to open"
  type        = list(any)
  default     = ["80", "443", "22", ]
}

variable "enable_detailed_monitoring" {
  default = "true"
  type    = bool
}

variable "common_tags" {
  description = "Common Tags for all resource"
  default = {
    Name        = "WebServer_SecG"
    Owner       = "Romads"
    Project     = "ZeroPlusPlus"
    CostCenter  = "12345"
    Environment = "DevOps"
  }
  type = map(any)
}*/
