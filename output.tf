output "apache-servers" {
    value = aws_instance.pub-ec2.public_ip
}