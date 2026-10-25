terraform {
  required_version = ">= 1.5.0"

  required_providers{
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
  }
  }

  
backend "s3" {
    bucket = "cloud-terraform-basics"
    key = "vpc/terraform.tfstate"
    use_lockfile = true
    region = "us-east-1"
    encrypt = true
    
}
}

