resource "aws_iam_role" "ecs_instance_role" {
  count = 1 # Ensure only one IAM role is created
  
name  = "ecs-public-instance-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "public-ecs-instance-profile"
  role = aws_iam_role.ecs_instance_role[0].name 
}

resource "aws_iam_role_policy_attachment" "ecs_instance_policy" {
  role       = aws_iam_role.ecs_instance_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}



resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecspublicTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy_attachment" "ecs_task_execution_policy" {
  name       = "ecs-task-execution-policy"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "ecs_public_secrets_policy" {
  name        = "public-ecs-secrets-access"
  description = "Allow ECS to access Secrets Manager"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      Resource = "arn:aws:secretsmanager:ap-southeast-1:497082176439:secret:private-docker-credentials-27MkrS"
    }]
  })
}

resource "aws_iam_policy_attachment" "ecs_task_secrets" {
  name       = "ecs-task-secrets-attach"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = aws_iam_policy.ecs_public_secrets_policy.arn
}
