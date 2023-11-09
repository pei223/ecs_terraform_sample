resource "aws_security_group" "rds_sg" {
  name        = "${var.pj_name}-${var.env}-rds-sg"
  description = "Allow PostgreSQL Port from worker subnets"
  vpc_id      = data.aws_vpc.root_vpc.id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = [
      data.aws_subnet.worker_subnet_1.cidr_block,
      data.aws_subnet.worker_subnet_2.cidr_block,
      // TODO Allow all ip temporary
      "0.0.0.0/0"
    ]
  }

  // Allow all egress
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : "${var.pj_name}-${var.env}-rds-sg"
  }
}