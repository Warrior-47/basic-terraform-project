provider "aws" {
    region = "us-west-2"
}

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my-vpc"
    }
}

resource "aws_subnet" "public-sub-1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "pub-sub-1"
    }
}

resource "aws_subnet" "public-sub-2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "pub-sub-2"
    }
}

resource "aws_subnet" "private-sub-1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1c"
    tags = {
        Name = "priv-sub-1"
    }
}

resource "aws_subnet" "private-sub-2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1d"
    tags = {
        Name = "priv-sub-2"
    }
}