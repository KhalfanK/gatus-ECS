aws_region = "eu-west-2"

vpc_cidr = "10.0.0.0/16"

public_subnets = {
  public_1 = {
    cidr = "10.0.0.0/24"
    az   = "eu-west-2a"
  }

  public_2 = {
    cidr = "10.0.1.0/24"
    az   = "eu-west-2b"
  }
}

private_subnets = {
  private_1 = {
    cidr = "10.0.2.0/24"
    az   = "eu-west-2a"
  }

  private_2 = {
    cidr = "10.0.3.0/24"
    az   = "eu-west-2b"
  }
}