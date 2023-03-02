resource "aws_launch_template" "http-serv-temp" {
    name = "http-serv-temp"
    image_id = data.aws_ami.amzn_linux.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.ec2-key.key_name
    vpc_security_group_ids = [ module.network-module.ssh-http-sg ]
    user_data = filebase64("scripts/apache.sh")

    tags = {
      Name = "pub-test"
    }
}

resource "aws_autoscaling_group" "http-serv-grp" {
    name = "http-serv-grp"
    max_size = 5
    min_size = 1
    desired_capacity = 3
    launch_template {
        id = aws_launch_template.http-serv-temp.id
        version = "$Latest"
    }
    vpc_zone_identifier = module.network-module.pub-subnet-ids
    target_group_arns = [ module.network-module.tg-arn ]
}

resource "aws_autoscaling_schedule" "bhor-shokal" {
    scheduled_action_name = "bhor-shokal"
    autoscaling_group_name = aws_autoscaling_group.http-serv-grp.name
    min_size = 1
    max_size = 1
    desired_capacity = 1
    start_time = "2023-03-03T00:00:00Z"
    end_time = "2023-03-03T06:00:00Z"
    recurrence = "0 * * * *"
    time_zone = "Asia/Dhaka"
}

resource "aws_autoscaling_schedule" "shokal-to-bikal" {
    scheduled_action_name = "shokal-to-bikal"
    autoscaling_group_name = aws_autoscaling_group.http-serv-grp.name
    min_size = 3
    max_size = 3
    desired_capacity = 3
    start_time = "2023-03-03T06:00:00Z"
    end_time = "2023-03-03T18:00:00Z"
    recurrence = "0 * * * *"
    time_zone = "Asia/Dhaka"
}

resource "aws_autoscaling_schedule" "bikal-to-raat" {
    scheduled_action_name = "bikal-to-raat"
    autoscaling_group_name = aws_autoscaling_group.http-serv-grp.name
    min_size = 1
    max_size = 1
    desired_capacity = 1
    start_time = "2023-03-03T18:00:00Z"
    end_time = "2023-03-04T00:00:00Z"
    recurrence = "0 * * * *"
    time_zone = "Asia/Dhaka"
}