resource "aws_ecs_cluster" "public_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_capacity_provider" "public_provider" {
  name = "public-provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.public_ecs_asg.arn
    managed_scaling {
      status          = "ENABLED"
      target_capacity = 100
    }
    managed_termination_protection = "ENABLED"
  }

}

resource "aws_ecs_cluster_capacity_providers" "public" {
  cluster_name = aws_ecs_cluster.public_cluster.name

  capacity_providers = [aws_ecs_capacity_provider.public_provider.name]
}
