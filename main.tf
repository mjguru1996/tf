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