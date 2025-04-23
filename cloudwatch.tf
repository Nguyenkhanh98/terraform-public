resource "aws_cloudwatch_log_group" "onair_logs_public" {
  name              = "/ecs/onair_public"
  retention_in_days = 30
}