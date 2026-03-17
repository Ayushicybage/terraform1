variable "aws_region" { default = "ap-south-1" }

variable "env" {}

variable "instance_type" { default = "t2.micro" }

variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}

variable "ami_id" {}

# DB
variable "db_name" { default = "appdb" }
variable "db_user" { default = "admin" }
variable "db_pass" { sensitive = true }