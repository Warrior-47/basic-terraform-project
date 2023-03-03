variable pub-subs {
    type = list(object({
        name = string,
        cidr = string,
        availability_zone = string
    }))
    default = [ {
      availability_zone = "us-west-2a"
      cidr = "10.0.0.0/24"
      name = "pub-sub-1"
    },
    {
        availability_zone = "us-west-2b"
        cidr = "10.0.1.0/24"
        name = "pub-sub-2"
    }]
}

variable priv-subs {
    type = list(object({
        name = string,
        cidr = string,
        availability_zone = string
    }))
    default = [ {
        availability_zone = "us-west-2c"
        cidr = "10.0.2.0/24"
        name = "priv-sub-1"
    },
    {
        availability_zone = "us-west-2a"
        cidr = "10.0.3.0/24"
        name = "priv-sub-2"
    }]
}