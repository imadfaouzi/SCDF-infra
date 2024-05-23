resource "aws_ecs_service" "this" {
  name            = var.name
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  service_registries {
    registry_arn = var.cloud_map_service_arn
    # port         = var.cloud_map_service_port
  }

  lifecycle {
    create_before_destroy = true
  }
}



# VARIABLES :

# module "ecs_service" {
#   source = "./ecs_service"

#   name                  = "my-mad-webpage-service"
#   cluster_id            = aws_ecs_cluster.my_mad_cluster.id
#   task_definition_arn   = aws_ecs_task_definition.my_mad_webpage_tf.arn
#   desired_count         = 1
#   subnets               = var.private_subnets
#   security_groups       = [aws_security_group.SecurityGroup_my_mad_service.id]
#   assign_public_ip      = false
#   cloud_map_service_arn = var.cloud_map_service_arn
#   cloud_map_service_port = 80
# }
