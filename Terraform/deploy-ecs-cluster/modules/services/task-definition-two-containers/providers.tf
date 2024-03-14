terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  alias = "ireland"
  region = "eu-west-1"
  
}