# =============================================================================
# Recursos AWS para el Servicio de Órdenes
# Este módulo define la infraestructura necesaria para desplegar el servicio
# =============================================================================

variable "alb_arn" {
  type        = string
  description = "ARN del Application Load Balancer al que conectar el listener"
}

# ECS Task Definition para el servicio de órdenes
resource "aws_ecs_task_definition" "orders_service" {
  family                   = "${var.service_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = var.service_name
      image     = "${var.service_name}:latest"
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "ENVIRONMENT", value = var.environment }
      ]
    }
  ])
}

# Target Group para el Application Load Balancer
# TODO(reto): Configurar health check path y otros parámetros según requisitos del servicio
resource "aws_lb_target_group" "orders" {
  name     = "${var.service_name}-tg"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/actuator/health"
    matcher             = "200"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Listener para el Application Load Balancer
# TODO(reto): Configurar reglas de routing y condiciones según requisitos del servicio
resource "aws_lb_listener" "orders" {
  load_balancer_arn = var.alb_arn
  port              = var.load_balancer_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orders.arn
  }
}

# ECS Service para el servicio de órdenes
resource "aws_ecs_service" "orders_service" {
  name            = var.service_name
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.orders_service.arn
  desired_count   = var.min_size
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [aws_security_group.ecs_service.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.orders.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.orders]

  lifecycle {
    create_before_destroy = true
  }
}

# Security Group para el servicio ECS
resource "aws_security_group" "ecs_service" {
  name        = "${var.service_name}-sg"
  description = "Security group para el servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Instance para la base de datos de órdenes
resource "aws_db_instance" "orders_db" {
  identifier     = "${var.service_name}-db"
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = var.db_instance_class

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = var.db_subnet_group_name

  backup_retention_period = 7
  skip_final_snapshot     = var.environment != "prod"
  deletion_protection     = var.environment == "prod"
}

# Security Group para RDS
resource "aws_security_group" "rds" {
  name        = "${var.service_name}-rds-sg"
  description = "Security group para RDS del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_service.id]
  }
}

# SQS Queue para procesamiento de órdenes
resource "aws_sqs_queue" "orders_queue" {
  name                      = "${var.service_name}-queue"
  message_retention_seconds = 345600
  max_message_size          = 262144
  delay_seconds             = 0
  receive_wait_time_seconds = 20

  tags = {
    Environment = var.environment
    Service     = var.service_name
  }
}

# Dead Letter Queue para mensajes fallidos
resource "aws_sqs_queue" "orders_dlq" {
  name                      = "${var.service_name}-dlq"
  message_retention_seconds = 1209600
  max_message_size          = 262144

  tags = {
    Environment = var.environment
    Service     = var.service_name
  }
}

# IAM Role para ejecución de tareas ECS
resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.service_name}-ecs-execution-role"

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

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# IAM Role para tareas ECS
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.service_name}-ecs-task-role"

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

# Policy para acceso a SQS
resource "aws_iam_policy" "sqs_access_policy" {
  name        = "${var.service_name}-sqs-access"
  description = "Permite acceso a la cola SQS del servicio de órdenes"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:SendMessage"
        ]
        Resource = aws_sqs_queue.orders_queue.arn
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.orders_dlq.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_sqs_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.sqs_access_policy.arn
}