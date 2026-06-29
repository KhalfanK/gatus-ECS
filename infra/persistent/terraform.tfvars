project = "gatus"

environment = "dev"

aws_region = "eu-west-2"

vpc_cidr = "10.0.0.0/24"

public_subnets = {
  public_1 = {
    cidr = "10.0.0.0/26"
    az   = "eu-west-2a"
  }

  public_2 = {
    cidr = "10.0.0.64/26"
    az   = "eu-west-2b"
  }
}

private_subnets = {
  private_1 = {
    cidr = "10.0.0.128/26"
    az   = "eu-west-2a"
  }

  private_2 = {
    cidr = "10.0.0.192/26"
    az   = "eu-west-2b"
  }
}