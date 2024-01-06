provider "aws" {
  region = "ap-northeast-1"
}

# VPCを作成する
# https://www.terraform.io/docs/providers/aws/r/vpc.html
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "basic_network"
  }
}
