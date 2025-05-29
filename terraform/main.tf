resource "aws_vpc" "medusa_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)

  vpc_id            = aws_vpc.medusa_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "medusa_igw" {
  vpc_id = aws_vpc.medusa_vpc.id
}

resource "aws_security_group" "medusa_sg" {
  name        = "medusa-sg"
  description = "Security group for Medusa ECS service"
  vpc_id      = aws_vpc.medusa_vpc.id

  ingress {
    from_port   = var.containerPort
    to_port     = var.containerPort
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_cluster" "medusa_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
  
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  
}

resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "medusa-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = var.container_name
    image     = var.ecr_image_url
    cpu       = tonumber(var.ecs_task_cpu)
    memory    = tonumber(var.ecs_task_memory)
    essential = true

    portMappings = [{
      containerPort = tonumber(var.containerPort)
      hostPort      = var.containerPort
      protocol      = "tcp"
    }]
  }])
  
}

resource "aws_ecs_service" "medusa_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.medusa_cluster.id
  task_definition = aws_ecs_task_definition.medusa_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = aws_subnet.public_subnets[*].id
    security_groups  = [aws_security_group.medusa_sg.id]
    assign_public_ip = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution_policy
  ]
  
}
