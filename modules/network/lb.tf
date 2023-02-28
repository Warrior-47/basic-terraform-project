resource "aws_lb" "alb" {
    name = "ALB"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.ssh_http]
    subnets = [aws_subnet.public-sub-1.id, aws_subnet.public-sub-2.id]
}

resource "aws_lb_target_group" "tg" {
    name = "tg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.my-vpc.id
    target_type = "instance"
    health_check {
        path = "/"
        port = 80
        protocol = "HTTP"
    }
}

resource "aws_lb_listener" "HTTP" {
    load_balancer_arn = aws_lb.alb
    port = 80
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tg.arn
    }
}