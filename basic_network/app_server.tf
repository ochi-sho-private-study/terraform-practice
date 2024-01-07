data "aws_ami" "latest_amzn2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "app_server" {
  key_name   = "ec2_key"
  public_key = file("~/Downloads/ec2_key.pub")
}

# インスタンス
resource "aws_instance" "app_server" {
  instance_type = "t3.micro" # インスタンスタイプは任意に設定する

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  ami = data.aws_ami.latest_amzn2.id

  subnet_id = aws_subnet.public_1a.id

  key_name = aws_key_pair.app_server.key_name

  tags = {
    Name = "app_server" # インスタンス名
  }

  lifecycle {
    ignore_changes = [
      ami # インスタンスに変更を加えようとしたら、AMIが新しくなっていてインスタンス再作成が要求されるのを防止するため
    ]
  }
}
