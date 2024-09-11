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