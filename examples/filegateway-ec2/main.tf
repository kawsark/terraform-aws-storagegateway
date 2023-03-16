provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source   = "aws-ia/vpc/aws"
  version = ">= 4.0.0"

  name       = "storage-gateway-vpc"
  cidr_block = "10.0.0.0/20"
  az_count   = 3

  subnets = {
    public = {
      name_prefix               = "my_public" # omit to prefix with "public"
      netmask                   = 24
      nat_gateway_configuration = "single_az" # options: "single_az", "none"
    }

    private = {
      # omitting name_prefix defaults value to "private"
      # name_prefix  = "private_with_egress"
      netmask      = 24
      connect_to_public_natgw = true
    }
  }

}