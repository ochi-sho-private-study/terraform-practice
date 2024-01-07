# Elastic IP
# https://www.terraform.io/docs/providers/aws/r/eip.html
resource "aws_eip" "nat_1a" {
  # vpc = trueは非推奨
  # https://github.com/aws-ia/terraform-aws-vpc/issues/125
  # https://dipeshmajumdar.medium.com/warning-argument-is-deprecated-use-domain-attribute-instead-8978f84c2b26
  domain = "vpc"

  tags = {
    Name = "basic_network-natgw-1a"
  }
}

# NAT Gateway
# https://www.terraform.io/docs/providers/aws/r/nat_gateway.html
resource "aws_nat_gateway" "nat_1a" {
  subnet_id     = aws_subnet.public_1a.id # NAT Gatewayを配置するSubnetを指定
  allocation_id = aws_eip.nat_1a.id       # 紐付けるElastic IP

  tags = {
    Name = "basic_network-1a"
  }
}
