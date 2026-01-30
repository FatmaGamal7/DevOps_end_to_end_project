variable "vpc_id" {
  description = "The VPC ID where the route table will be created"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to associate with the route table"
  type        = string
}

variable "igw_id" {
  description = "The Internet Gateway ID for the public route table"
  type        = string
}
