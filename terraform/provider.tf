terraform {
  backend "s3" {
    bucket       = "outline-terraform-state-abdullahi"
    key          = "outline/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.16.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
