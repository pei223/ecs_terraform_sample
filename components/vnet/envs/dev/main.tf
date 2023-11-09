terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "ecs-terraform-sample"
    key    = "vpc-dev"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "main" {
  source = "../../"

  providers = {
    aws = aws
  }

  pj_name = "ecs_terraform_sample"
  env     = "dev"
}