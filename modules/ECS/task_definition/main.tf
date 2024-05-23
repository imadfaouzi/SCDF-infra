resource "aws_ecs_task_definition" "this" {
  family                   = var.family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  skip_destroy             = var.skip_destroy

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.docker_image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true

      portMappings = var.port_mappings
    }
  ])
}


# HOW TO USE IT :
# module "ecs_task_definition" {
#   source = "./ecs_task_definition"

#   family          = "my-task-family"
#   cpu             = "512"
#   memory          = "1024"
#   skip_destroy    = true
#   container_name  = "my-container"
#   docker_image    = "my-docker-image:latest"
#   container_cpu   = 256
#   container_memory = 512
#   port_mappings = [
#     {
#       containerPort = 80
#       hostPort      = 80
#       protocol      = "tcp"
#     }
#   ]
# }
