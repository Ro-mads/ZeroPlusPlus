provider "aws" {}


variable "aws_users" {
  default     = ["Roman", "Ilias", "Valera", "Niko"]
  description = "List of IAM Users"
}

resource "aws_iam_user" "user1" {
  name = "liston"
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)

}

output "created_iam_users_all" {
  value = aws_iam_user.users
}

output "created_iam_ids" {
  value = aws_iam_user.users[*].id
}

output "created_iam_users_custom" {
  value = [
    for user in aws_iam_user.users :
    "Username: ${user.name} has ARN: ${user.arn}"
  ]
}

output "create_iam_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.unique_id => user.id
  }
}

output "custom_if" {
  value = [
    for x in aws_iam_user.users :
    x.name
    if length(x.name) == 4
  ]
}

resource "aws_instance" "servers" {
  count         = 3
  ami           = "ami-070b208e993b59cea"
  instance_type = "t3.micro"
  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}

output "server_all" {
  value = {
    for server in aws_instance.servers :
    server.id => server.public_ip
  }


}
