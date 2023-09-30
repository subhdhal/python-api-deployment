output "public_subnet_id" {
  value       = aws_subnet.public_subnet.id
}

output "ecs_sg_id" {
  value       = aws_security_group.ecs_security_group.id
}