resource "aws_route_table" "pr" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }

  tags = {
    Name = "private rt for subnet:${var.subnet_id}"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.pr.id
}
