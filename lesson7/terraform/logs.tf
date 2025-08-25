resource "aws_cloudwatch_log_group" "nginx" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 7
  tags              = { Name = "${var.project_name}-logs" }
}
