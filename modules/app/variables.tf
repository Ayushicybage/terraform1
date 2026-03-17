variable "vpc_id" {}

variable "subnets" {
  type = list(string)
}

variable "target_arn" {}

variable "db_endpoint" {}

variable "instance_type" {}

variable "desired_capacity" {}

variable "min_size" {}

variable "max_size" {}

variable "ami_id" {}

variable "env" {}