variable "region" {
  type = string
}

variable "env" {
  description = "Environment name: prod or nonprod"
  type        = string
  default = "prod"
}

variable "vpc_cidr_prod" {
  type = string
}

variable "vpc_cidr_nonprod" {
  type = string
}

variable "public_cidr_prod" {
  type = string
}

variable "private_cidr_prod" {
  type = string
}

variable "public_cidr_nonprod" {
  type = string
}

variable "private_cidr_nonprod" {
  type = string
}

variable "availability_zone_1" {
  type = string
}

variable "availability_zone_2" {
  type = string
}
