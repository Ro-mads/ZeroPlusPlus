provider "aws" {}

resource "aws_instance" "Server" {
  ami           = "ami-0caef02b518350c8b"
  instance_type = "t3.micro"
  provisioner "local-exec" {
    command = "echo Hi from Deutschland"

  }
}

resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo Terraform START: $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }
}

//depends_on = [null_resource.command1]


resource "null_resource" "command3" {
  provisioner "local-exec" {
    command     = "print('Hi there')"
    interpreter = ["python", "-c"]
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 $NAME3 >> names.txt"
    environment = {
      NAME1 = "Laura"
      NAME2 = "Julia"
      NAME3 = "Roman"
    }
  }
}


resource "null_resource" "command5" {
  provisioner "local-exec" {
    command = "echo Terraform END: $(date) >> log.txt"
  }
  depends_on = [null_resource.command1, null_resource.command2, null_resource.command3, null_resource.command4, aws_instance.Server]
}
