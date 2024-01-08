# APPサーバー用セキュリティグループ
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Security group for application server"
  vpc_id      = aws_vpc.main.id

  # インバウンドルール
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["60.134.210.222/32"] # 開発者のIP範囲に置き換えてください
  }

  # アウトバウンドルール（全てのトラフィックを許可）
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app-sg"
  }
}

# DBサーバー用セキュリティグループ
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Security group for database server"
  vpc_id      = aws_vpc.main.id

  # インバウンドルール（APPサーバーからのアクセスを許可）
  ingress {
    description     = "Access from APP Server"
    from_port       = 3306 # DBが使用するポート番号に置き換えてください
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  # アウトバウンドルール（特定の宛先へのトラフィックを許可）
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # インターネットにアクセスする際は、以下の順番でアクセスするため、cidr_blocksは0.0.0.0/0にする。
    # DBサーバー => セキュリティグループのアウトバウンドルールチェック => NATゲートウェイ => 目的のサイト
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}
