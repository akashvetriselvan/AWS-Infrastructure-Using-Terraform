# General project name
variable "project" {
  description = "Project name for tagging resources"
  default     = "project3"
}

# VPC
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}
variable "availability_zone" {
  description = "Availability zone for subnet"
  default     = "ap-south-1a"
}

# EC2
variable "ami" {
  description = "AMI ID for EC2 instance"
  default     = "ami-0eb5549427fc55d57" # ✅ Amazon Linux 2 for ap-south-1
}


variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
variable "key_name" {
  description = "EC2 Key Pair for SSH access"
  default     = "project3-key" 
}

# S3
variable "s3_bucket_name" {
  description = "Name of S3 bucket"
  default     = "project3-bucket"
}

# DynamoDB
variable "dynamodb_table_name" {
  description = "DynamoDB table name for Terraform locking"
  default     = "project3-lock-table"
}

