terraform {

    required_version = ">= 1.5.0"
    required_providers {
        aws = {
             sourve = "hashicorp/aws"
             version = "~> 5.0"
        }      
        
    }

    backend "s3" {
        bucket = "cloud-terraform-basics"
        key = "alb/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}


data "terraform_remote_state" "vpc"{
    backend = "s3"
    config = {
        bucket = var.terraform_state_bucket
        key = "vpc/vpc1/terraform.tfstate"
        region = var.terraform_state_region
    }
}