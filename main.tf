provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAUGO4K25OTHVAE7YO"
  secret_key = "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"
}

resource "aws_instance" "web" {
    ami = "ami-0522ab6e1ddcc7055"
    instance_type = "t2.micro"
    tags = {
    Name = "webserver"
  }
}
resource "aws_vpc" "nab" {
    cidr_block = "10.1.0.0/16"
     tags = {
    Name = "production"
  }  
}
resource "aws_subnet" "public" {
vpc_id = aws_vpc.nab.id
cidr_block = "10.1.0.0/24"
tags = {
    Name = "production-subnet"
  }  
}