provider "aws" {
    region = "us-west-2"
}

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my-vpc"
    }
}

resource "aws_subnet" "public-subnets" {
    count = length(var.pub-subs)
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = element(var.pub-subs, count.index).cidr
    availability_zone = element(var.pub-subs, count.index).availability_zone
    tags = {
        Name = element(var.pub-subs, count.index).name
    }
}

resource "aws_subnet" "private-subnets" {
    count = length(var.priv-subs)
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = element(var.priv-subs, count.index).cidr
    availability_zone = element(var.priv-subs, count.index).availability_zone
    tags = {
        Name = element(var.priv-subs, count.index).name
    }
}

resource "aws_security_group" "ssh-http" {
    name = "ssh_http"
    vpc_id = aws_vpc.my-vpc.id
    ingress {
        description = "ssh access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "http access"
        from_port = 80
        to_port = 80
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
      Name = "ssh_http"
    }
}

resource "aws_security_group" "ssh-private" {
    name = "ssh_private"
    vpc_id = aws_vpc.my-vpc.id
    ingress {
        description = "private ssh access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [aws_vpc.my-vpc.cidr_block]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    tags = {
      Name = "ssh_private"
    }
}