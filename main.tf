provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAUGO4K25OTHVAE7YO"
  secret_key = "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"
}
resource "aws_vpc" "nab" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "nab"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.nab.id
  tags = {
    Name = "gw"
  }
}
resource "aws_route_table" "prod-rt" {
  vpc_id = aws_vpc.nab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "prod-rt"
  }
}