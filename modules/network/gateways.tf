resource "aws_eip" "nat-ip" {
    vpc = true
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "IGW"
    }
}

resource "aws_nat_gateway" "ngw" {
    allocation_id = aws_eip.nat-ip.id
    subnet_id = aws_subnet.public-sub-1.id
    depends_on = [
      aws_internet_gateway.igw
    ]
    tags = {
        Name = "NGW"
    }
}