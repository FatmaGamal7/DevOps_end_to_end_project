resource "aws_vpc" "main" {
    cidr_block = var.cidr_block

    tags = {
      Name = "vpc with Cidr: ${var.cidr_block}"
    }
  
}