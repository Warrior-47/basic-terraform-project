provider "aws" {
    region = "us-west-2"
}

module "network-module" {
    source = "./modules/network"
}

resource "aws_key_pair" "ec2-key" {
    key_name = "ec2-key"
    public_key = file("keys/ec2-key.pub")
}

resource "aws_instance" "priv-ec2" {
    count = 2
    ami = data.aws_ami.amzn_linux.id
    instance_type = "t2.micro"
    key_name = aws_key_pair.ec2-key.key_name
    security_groups = [ module.network-module.ssh-priv-sg ]

    subnet_id = element(module.network-module.priv-subnet-ids, count.index)
    tags = {
      Name = "private-${count.index}"
    }
}

resource "aws_lb_target_group_attachment" "instance-attach" {
    count = 2
    target_group_arn = module.network-module.tg-arn
    target_id = element(aws_instance.pub-ec2, count.index).id
}