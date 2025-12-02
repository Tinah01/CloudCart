resource "aws_db_subnet_group" "rds_subnets" {
  name       = "${var.project}-rds-subnet"
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_db_instance" "db" {
  identifier             = "${var.project}-db"
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"
  allocated_storage      = var.db_allocated_storage
  db_name                = "cloudcartdb"
  username               = var.db_username
  password               = "xyzabcd1234!"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
}
