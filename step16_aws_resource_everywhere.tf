provider "aws" {
  /*assume_role {
    role_arn = "arn:aws:iam:1234567:role/Administrators"
    session_name = "Terraform_Session"
  } login in other accounts*/
}

provider "aws" {
  region = "us-east-1"
  alias  = "USA"
}

provider "aws" {
  region = "eu-central-1"
  alias  = "GER"
}

//kann auch und andere provider hinzufügen als Azure,Google,DO,Terraform

/*data "aws_ami" "usa_latest_ubuntu" {
  provider    = aws.usa
  owners      = ["4574564563456"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/image/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

data "aws_ami" "ger_latest_ubuntu" {
  provider    = aws.GER
  owners      = ["4574564563456"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/image/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}*/




resource "aws_instance" "eu_server" {
  instance_type = "t3.micro"
  ami           = "ami-070b208e993b59cea" //data.aws_ami.ger_latest_ubuntu.id search latest ISO datei
  tags = {
    Name = "Default Server"
  }
}


resource "aws_instance" "USA_server" {
  provider      = aws.USA
  instance_type = "t3.micro"
  ami           = "ami-08c40ec9ead489470" //data.aws_ami.usa_latest_ubuntu.id search latest ISO datei
  tags = {
    Name = "USA_server"
  }
}

resource "aws_instance" "ger_server" {
  provider      = aws.GER
  instance_type = "t3.micro"
  ami           = "ami-070b208e993b59cea" //data.aws_ami.usa_latest_ubuntu.id search latest ISO datei
  tags = {
    Name = "Germany Server"
  }

}
