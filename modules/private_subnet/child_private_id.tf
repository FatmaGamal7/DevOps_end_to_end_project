resource "aws_subnet" "private" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone

  tags = {
    Name = "private-subnet-${var.cidr_block}"
  }

}