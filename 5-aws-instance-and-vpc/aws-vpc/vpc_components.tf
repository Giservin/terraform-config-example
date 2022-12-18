provider "aws" {
  region = "us-east-1"
}

data "aws_region" "current" { }

resource "aws_vpc" "VPC" {
  cidr_block = var.VpcCidr
  enable_dns_support = var.dnsSupport
  enable_dns_hostnames = var.dnsSupport

  tags = {
    Name : "Test VPC"
  }

}

resource "aws_internet_gateway" "IGW" {
  tags = {
    Name = "Test IGW"
  }
}

resource "aws_internet_gateway_attachment" "VPCtoIGW" {
    depends_on = [
      aws_vpc.VPC,
      aws_internet_gateway.IGW
    ]

    internet_gateway_id = aws_internet_gateway.IGW.id
    vpc_id = aws_vpc.VPC.id
}

resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.VPC.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name : "Public Route Table"
  }
}

resource "aws_route_table" "PrivateRouteTable" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name : "Private Route Table"
  }
}

