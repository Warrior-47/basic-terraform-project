data "aws_ami" "amzn_linux" {
    most_recent = true
    owners = ["self"]
    filter {
      name = "name"
      values = [ "Amazon Linux*" ]
    }
}