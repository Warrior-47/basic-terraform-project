provider "aws" {
    region = "us-west-2"
}

module "network-module" {
    source = "./modules/network"
}