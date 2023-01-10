provider "aws" {}

terraform {
  backend "s3" {
    bucket = "S3bucket pfad"
    key    = "globalvars/terraform.tfstate"
    region = "us-eas-1"
  }
}

output "company_name" {
  value = "ZeroPlusPlus International"
}

output "owner" {
  value = "Romads"
}

output "tags" {
  value = {
    Project    = "Assembly-2023"
    CostCenter = "R&D"
    Country    = "Germany"
  }
}
