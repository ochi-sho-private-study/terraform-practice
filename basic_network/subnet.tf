# Subnet
# https://www.terraform.io/docs/providers/aws/r/subnet.html
resource "aws_subnet" "public_1a" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "handson-public-1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id = aws_vpc.main.id

  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "handson-public-1c"
  }
}
