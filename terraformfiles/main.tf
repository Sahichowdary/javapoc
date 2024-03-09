provider "aws" {
  region = var.region
  alias  = "use_default_region"
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
