resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Route Table"
  }
}


resource "aws_route" "route_table"{
  route_table_id = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "route_table"{
  subnet_id = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}
