provider "aws" {
    region = "us-west-2"
}

module "network-module" {
    source = "./modules/network"
}

resource "aws_instance" "test-ec2" {
    ami = "ami-0f1a5f5ada0e7da53"
    instance_type = "t2.micro"
    subnet_id = module.network-module.pub-subnet1-id
    security_groups = [ module.network-module.ssh-sg ]
}