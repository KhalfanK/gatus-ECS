terraform {
  backend "s3" {
    bucket       = "terraform-state-gatus"
    key          = "ephemeral/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}