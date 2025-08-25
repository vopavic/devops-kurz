# ECS cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = { Name = "${var.project_name}-cluster" }
}

# Task Definition: nginx:alpine, 256 CPU / 512 MB, logs -> CloudWatch
resource "aws_ecs_task_definition" "nginx" {
  family                   = "${var.project_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = "nginx"
    image = "nginx:alpine"
    portMappings = [{
      containerPort = 80
      protocol      = "tcp"
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.nginx.name
        awslogs-region        = var.aws_region
        awslogs-stream-prefix = "ecs"
      }
    }

    essential = true
  }])

  tags = { Name = "${var.project_name}-task" }
}

# ECS Service (1 task), Fargate, za ALB
resource "aws_ecs_service" "nginx" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  platform_version = "LATEST"

  network_configuration {
    subnets         = data.aws_subnets.vpc.ids
    security_groups = [aws_security_group.ecs_tasks.id]
    assign_public_ip = true  # protože default VPC subnets jsou public
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.http]

  tags = { Name = "${var.project_name}-service" }
}
