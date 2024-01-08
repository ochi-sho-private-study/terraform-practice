resource "aws_db_subnet_group" "test_db" {
  name        = "test-db-subnet-group"
  description = "For Test DB Subnet Group"

  # 既存のprivateサブネットを指定する
  subnet_ids = [aws_subnet.private_1a.id, aws_subnet.private_1c.id]

  tags = {
    Name = "TestDBSubnetGroup"
  }
}

resource "aws_db_instance" "test_db" {
  allocated_storage      = 20    # 無料枠の制限内
  storage_type           = "gp2" # SSDにする
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro" # 無料枠のインスタンスタイプ
  db_name                = "mydb"
  username               = "admin"
  password               = "password"
  parameter_group_name   = "default.mysql8.0"
  db_subnet_group_name   = aws_db_subnet_group.test_db.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  backup_retention_period = 7
  skip_final_snapshot     = true

  # シングルAZ配置を指定
  multi_az = false
}
