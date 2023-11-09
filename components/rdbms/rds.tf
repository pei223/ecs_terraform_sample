resource "random_password" "db_password" {
  length           = 16
  special          = false
}

resource "aws_secretsmanager_secret" "db_secret" {
  name = "${var.pj_name}-${var.env}-db-secret"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = random_password.db_password.result
}

resource "aws_db_instance" "db" {
  identifier = "${var.pj_name}-${var.env}-db"
  engine            = "postgres"
  engine_version    = "11"
  instance_class    = "db.t2.micro"
  allocated_storage = 30
  storage_type      = "gp2"

  publicly_accessible    = true
  multi_az               = true
  username               = "postgresadmin"
  password               = random_password.db_password.result
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  backup_window              = "18:00-18:30"
  maintenance_window         = "sat:19:00-sat:19:30"
  auto_minor_version_upgrade = true
  copy_tags_to_snapshot      = true
  backup_retention_period    = 7
  deletion_protection        = false

  tags = {
    "Name" : "${var.pj_name}-${var.env}-db"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.db.endpoint
}