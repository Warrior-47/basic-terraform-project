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
    availability_zone = "us-west-2a"
    map_public_ip_on_launch = true
    tags = {
        Name = "pub-sub-1"
    }
}

resource "aws_subnet" "public-sub-2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-2b"
    map_public_ip_on_launch = true
    tags = {
        Name = "pub-sub-2"
    }
}

resource "aws_subnet" "private-sub-1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-west-2c"
    tags = {
        Name = "priv-sub-1"
    }
}

resource "aws_subnet" "private-sub-2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-west-2d"
    tags = {
        Name = "priv-sub-2"
    }
}

resource "aws_security_group" "ssh-only" {
    name = "ssh_only"
    vpc_id = aws_vpc.my-vpc.id
    ingress {
        description = "public-ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
      Name = "ssh_only"
    }
}