resource "aws_vpc" "root_vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.pj_name}-${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.root_vpc.id
  tags = {
    "Name" : "${var.pj_name}-${var.env}-igw"
  }
}