output "apache-servers" {
    value = [aws_instance.pub-ec2[0].public_ip, aws_instance.pub-ec2[1].public_ip]
}