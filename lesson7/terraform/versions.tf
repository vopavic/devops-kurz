terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # ZMĚŇ podle svého účtu/regionu
    bucket         = "tfstate-659571592784-us-east-1"
    key            = "ecs-nginx-demo/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
