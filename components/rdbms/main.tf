terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_vpc" "root_vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.pj_name}-${var.env}-vpc"]
  }
}