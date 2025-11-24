terraform {
  backend "s3" {
    bucket         = "project3-bucket-518d0e24"   # ✅ your actual bucket name
    key            = "terraform/state.tfstate"
    region         = "ap-south-1"
    use_lockfile   = true                         # ✅ new replacement for DynamoDB lock
    encrypt        = true
  }
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"   # AWS region
  profile = "default"       # AWS CLI profile name
}

# VPC Module Call
module "vpc" {
  source             = "./modules/vpc"
  project            = var.project
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
}

module "security_group" {
  source = "./modules/security-group"
  project = var.project
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  project           = var.project
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = module.vpc.subnet_id
  security_group_id = module.security_group.security_group_id
  key_name          = var.key_name
}

module "s3" {
  source          = "./modules/s3"
  project         = var.project
  s3_bucket_name  = var.s3_bucket_name


}

module "dynamodb" {
  source  = "./modules/dynamodb"
  project = var.project
}
module "cloudwatch" {
  source       = "./modules/cloudwatch"
  project      = var.project
  instance_id  = module.ec2.instance_id
  alarm_email  = "your-email@example.com"  # Replace with your real email
}


