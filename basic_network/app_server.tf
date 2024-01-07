resource "aws_key_pair" "app_server" {
  key_name   = "ec2_key"
  public_key = file("~/Downloads/ec2_key.pub")
}

resource "aws_instance" "app_server" {
  ami           = "ami-07c589821f2b353aa"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_1a.id

  key_name               = aws_key_pair.app_server.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "app_server"
  }
}
