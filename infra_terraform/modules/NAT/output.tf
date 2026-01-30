output "nat_id" {
  description = "The NAT Gateway ID"
  value       = aws_nat_gateway.this.id
}

output "nat_eip" {
  description = "The public IP of the NAT Gateway"
  value       = aws_eip.nat_ip.public_ip
}
