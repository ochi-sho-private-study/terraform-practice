provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "minimum_ec2_server" {
  # https://zenn.dev/supersatton/articles/c87853cc5a3dbd
  ami           = "ami-0dfa284c9d7b2adad"
  instance_type = "t2.micro"
  subnet_id = "subnet-0274f6b9bdd43120c"

  tags = {
    Name = "minimum_ec2_server"
  }
}
