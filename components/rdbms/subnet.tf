data "aws_subnet" "rds_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["${var.pj_name}-${var.env}-rds-subnet-1"]
  }
}

data "aws_subnet" "rds_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["${var.pj_name}-${var.env}-rds-subnet-2"]
  }
}

data "aws_subnet" "worker_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["${var.pj_name}-${var.env}-worker-subnet-1"]
  }
}

data "aws_subnet" "worker_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["${var.pj_name}-${var.env}-worker-subnet-2"]
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "${var.pj_name}-${var.env}-db-subnet-group"
  subnet_ids = [
    data.aws_subnet.rds_subnet_1.id,
    data.aws_subnet.rds_subnet_2.id
  ]

  tags = {
    "Name" : "${var.pj_name}-${var.env}-db-subnet-group"
  }
}