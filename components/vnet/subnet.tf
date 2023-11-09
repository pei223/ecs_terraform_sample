resource "aws_subnet" "worker_subnet_1" {
  vpc_id            = aws_vpc.root_vpc.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "192.168.1.0/24"
  tags = {
    "Name" : "${var.pj_name}-${var.env}-worker-subnet-1"
  }
}

resource "aws_subnet" "worker_subnet_2" {
  vpc_id            = aws_vpc.root_vpc.id
  availability_zone = "ap-northeast-1c"
  cidr_block        = "192.168.2.0/24"
  tags = {
    "Name" : "${var.pj_name}-${var.env}-worker-subnet-2"
  }
}

resource "aws_subnet" "rds_subnet_1" {
  vpc_id            = aws_vpc.root_vpc.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "192.168.10.0/24"
  tags = {
    "Name" : "${var.pj_name}-${var.env}-rds-subnet-1"
  }
}

resource "aws_subnet" "rds_subnet_2" {
  vpc_id            = aws_vpc.root_vpc.id
  availability_zone = "ap-northeast-1c"
  cidr_block        = "192.168.11.0/24"
  tags = {
    "Name" : "${var.pj_name}-${var.env}-rds-subnet-2"
  }
}

resource "aws_route_table" "default_rt" {
  vpc_id = aws_vpc.root_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    "Name" : "${var.pj_name}-${var.env}-default-internet-routing"
  }
}

resource "aws_route_table_association" "default_rt_association1" {
  subnet_id      = aws_subnet.worker_subnet_1.id
  route_table_id = aws_route_table.default_rt.id
}

resource "aws_route_table_association" "default_rt_association2" {
  subnet_id      = aws_subnet.worker_subnet_2.id
  route_table_id = aws_route_table.default_rt.id
}

resource "aws_route_table_association" "default_rt_rds_association1" {
  subnet_id      = aws_subnet.rds_subnet_1.id
  route_table_id = aws_route_table.default_rt.id
}

resource "aws_route_table_association" "default_rt_rds_association2" {
  subnet_id      = aws_subnet.rds_subnet_2.id
  route_table_id = aws_route_table.default_rt.id
}