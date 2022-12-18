data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name = "zone-type"
    values = ["availability-zone"]
  }
}

resource "aws_subnet" "PublicSubnet" {
  vpc_id = aws_vpc.VPC.id
  map_public_ip_on_launch = true
  cidr_block = var.publicSubnetCidr

  availability_zone = data.aws_availability_zones.available.names[1 % length(data.aws_availability_zones.available.names)]

  tags = {
    Name : "Public Subnet"
  }
}

resource "aws_subnet" "PrivateSubnet" {
  vpc_id = aws_vpc.VPC.id
  cidr_block = var.privateSubnetCidr

  availability_zone = data.aws_availability_zones.available.names[0 % length(data.aws_availability_zones.available.names)]

  tags = {
    Name : "Private Subnet"
  }
}

resource "aws_route_table_association" "PublicRouteAssociation" {
  depends_on = [aws_subnet.PublicSubnet, aws_route_table.PublicRouteTable]

  subnet_id = aws_subnet.PublicSubnet.id
  route_table_id = aws_route_table.PublicRouteTable.id
}

resource "aws_route_table_association" "PrivateRouteAssociation" {
  depends_on = [aws_subnet.PrivateSubnet, aws_route_table.PrivateRouteTable]

  subnet_id = aws_subnet.PrivateSubnet.id
  route_table_id = aws_route_table.PrivateRouteTable.id
}