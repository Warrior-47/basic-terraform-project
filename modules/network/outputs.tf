output "vpc-id" {
    value = aws_vpc.my-vpc.id
}

output "pub-subnet-ids" {
    value = [aws_subnet.public-sub-1.id, aws_subnet.public-sub-2.id]
}

output "priv-subnet-ids" {
    value = [aws_subnet.private-sub-1.id, aws_subnet.private-sub-2.id]
}

output "ssh-http-sg" {
    value = aws_security_group.ssh-http.id
}

output "ssh-priv-sg" {
    value = aws_security_group.ssh-private.id
}

output "tg-arn" {
    value = aws_lb_target_group.tg.arn
}