variable "public_subnet_id" {
  description = "The ID of the public subnet for NAT Gateway"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID (for dependency)"
  type        = string
}

variable "env" {
  description = "Environment name (prod/nonprod)"
  type        = string
}
