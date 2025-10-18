terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.16.0" # Maybe Add a version constraint to prevent breaking changes
    }
  }
}

provider "aws" {
  region = var.aws_region
}
