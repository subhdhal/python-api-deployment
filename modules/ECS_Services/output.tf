output "ecs_cluster_arn" {
  description = "ID of the ECS Cluster"
  value       = aws_ecs_service.my_service.cluster
}