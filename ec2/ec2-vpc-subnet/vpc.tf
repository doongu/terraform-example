provider "aws"{
  region = "ap-northeast-2"
}

data "aws_availability_zones" "available"{
  state = "available"
}

resource "aws_vpc" "vpc"{
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    "Name" = "vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW"
  }
}


