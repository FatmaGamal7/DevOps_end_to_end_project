output "alb_arn" {
  value = aws_lb.this.arn
}

output "sg_id" {
  value = aws_lb.alb_sg.id
}
