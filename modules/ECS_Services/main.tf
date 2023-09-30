resource "aws_ecs_task_definition" "my_task_definition" {
  family = "python-api-task"
  cpu = "1024"
  memory = "2048"
  container_definitions    = jsonencode([
  {
    "name": "python-api-container",
    "image": var.AWS_ECR_DOCKER_IMAGE_URI,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp",
      }
    ],
    "essential": true,
    "healthCheck": {
      "command": ["CMD-SHELL", "curl -f http://localhost/ || exit 1"],
      "interval": 30,
      "timeout": 5,
      "retries": 3,
      "startPeriod": 60
    }
  }
])

  requires_compatibilities = ["FARGATE"]  # Used Fargate launch type

  network_mode            = "awsvpc"
  execution_role_arn      = var.ecs_execution_task_role_arn 
}

# Create an ECS service to run the task
resource "aws_ecs_service" "my_service" {
  name            = var.name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = ["${var.public_subnet_id}"] 
    security_groups = ["${var.ecs_sg_id}"]
    assign_public_ip = true
  }
}