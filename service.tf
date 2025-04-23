# ECS Service for Next.js Frontend
resource "aws_ecs_service" "onair_fe_service" {
  name                               = "onair_fe-service"
  cluster                            = aws_ecs_cluster.public_cluster.id
  task_definition                    = aws_ecs_task_definition.onair_fe.arn
  desired_count                      = 2
  launch_type                        = "EC2"
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

    placement_constraints {
    type       = "distinctInstance"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.onair_fe_tg.arn
    container_name   = "onair_fe-container"
    container_port   = 3000
  }
}

# ECS Service for Admin Panel
resource "aws_ecs_service" "onair_admin_service" {
  name                               = "onair_admin-service"
  cluster                            = aws_ecs_cluster.public_cluster.id
  task_definition                    = aws_ecs_task_definition.onair_admin.arn
  desired_count                      = 1
  launch_type                        = "EC2"
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

    placement_constraints {
    type       = "distinctInstance"
  }


  load_balancer {
    target_group_arn = aws_lb_target_group.onair_admin_tg.arn
    container_name   = "onair_admin-container"
    container_port   = 3003
  }
}

# ECS Service for Host Panel
resource "aws_ecs_service" "onair_host_service" {
  name                               = "onair_host-service"
  cluster                            = aws_ecs_cluster.public_cluster.id
  task_definition                    = aws_ecs_task_definition.onair_host.arn
  desired_count                      = 2
  launch_type                        = "EC2"
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

    placement_constraints {
    type       = "distinctInstance"
  }


  load_balancer {
    target_group_arn = aws_lb_target_group.onair_host_tg.arn
    container_name   = "onair_host-container"
    container_port   = 3001
  }
}
