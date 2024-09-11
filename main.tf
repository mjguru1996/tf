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
resource "aws_subnet" "prod-subnet" {
cidr_block = "10.0.1.0/24"
vpc_id = aws_vpc.nab.id
availability_zone = "ap-south-1a"
tags = {
    Name = "prod-subnet"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.prod-subnet.id
  route_table_id = aws_route_table.prod-rt.id
}
resource "aws_vpc" "mainvpc" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.mainvpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_network_interface" "prod" {
  subnet_id       = aws_subnet.prod-subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_default_security_group.default.id]
}
