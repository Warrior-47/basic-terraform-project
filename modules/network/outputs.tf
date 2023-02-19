output "vpc-id" {
    value = aws_vpc.my-vpc.id
}

output "pub-subnet1-id" {
    value = aws_subnet.public-sub-1.id
}

output "pub-subnet2-id" {
    value = aws_subnet.public-sub-2.id
}

output "priv-subnet1-id" {
    value = aws_subnet.private-sub-1.id
}

output "priv-subnet2-id" {
    value = aws_subnet.private-sub-2.id
}

output "ssh-sg" {
    value = aws_security_group.ssh-only.id
}