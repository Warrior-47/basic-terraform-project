data "aws_ami" "amzn_linux" {
    most_recent = true
    owners = ["amazon"]
    filter {
      name = "name"
      values = [ "amzn2-ami-hvm*" ]
    }
}