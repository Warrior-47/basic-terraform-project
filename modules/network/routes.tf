resource "aws_route_table" "public" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "public-rt"
    }
    depends_on = [
      aws_internet_gateway.igw
    ]
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ngw.id
    }
    tags = {
        Name = "private-rt"
    }
    depends_on = [
      aws_nat_gateway.ngw
    ]
}

resource "aws_route_table_association" "public" {
    count = length(var.pub-subs)
	route_table_id = aws_route_table.public.id
	subnet_id = element(aws_subnet.public-subnets, count.index).id
}

resource "aws_route_table_association" "private" {
    count = length(var.priv-subs)
	route_table_id = aws_route_table.private.id
	subnet_id = element(aws_subnet.private-subnets, count.index).id
}