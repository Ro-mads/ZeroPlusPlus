provider "aws" {}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}





locals {
  full_project_name = "${var.environment}-${var.project_name}"
  project_owner     = "${var.owner} owner of ${var.project_name}"
  az_list           = join(",", data.aws_availability_zones.available.names)
  location          = "In ${local.region} there are AZ: ${local.az_list}"
  region            = data.aws_region.current.description
}


locals {
  country = "Greece"
  city    = "Athitos"
}


resource "aws_eip" "my_static_ip" {
  tags = {
    name  = "Static IP"
    Owner = var.owner
    //Project = "${var.environment}-${var.project_name}" //combination variables
    Project    = local.full_project_name
    proj_owner = local.project_owner
    city       = local.city
    region_azs = local.az_list
    location   = local.location
  }
}
