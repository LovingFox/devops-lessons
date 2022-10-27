terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "this" {
  ami                       = "ami-0caef02b518350c8b"
  instance_type             = "t2.micro"
}
