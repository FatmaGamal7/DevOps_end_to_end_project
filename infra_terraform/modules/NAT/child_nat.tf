
resource "aws_eip" "nat_ip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip-${var.env}"
  }
}


resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.env}-nat"
  }

  depends_on = [var.igw_id]
}
