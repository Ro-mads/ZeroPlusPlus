provider "aws" {}


resource "aws_instance" "firsttwo" {
  ami           = "ami-070b208e993b59cea"
  instance_type = "t3.micro"

  tags = {
    Name    = "My test Servers"
    Owner   = "Romads"
    Project = "Terraform DevOps lern"
  }

}

/* mehere Servers mit count
resource "aws_instance" "firsttwo" {
  count         = 3
  ami           = "ami-070b208e993b59cea"
  instance_type = "t3.micro"
}
*/
