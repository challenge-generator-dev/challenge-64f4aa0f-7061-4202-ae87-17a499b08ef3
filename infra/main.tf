# Configuración principal de Terraform para el servicio de órdenes
# Este archivo orchestra el despliegue de la infraestructura AWS

terraform {
  backend "s3" {
    bucket         = "terraform-state-${var.service_name}"
    key            = "infra/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

# Variables requeridas para el módulo de orders_service
variable "ecs_cluster_id" {
  type        = string
  description = "ID del cluster ECS donde se desplegará el servicio"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs de las subnets privadas donde se desplegarán los recursos"
}

variable "vpc_id" {
  type        = string
  description = "ID de la VPC donde se crearán los recursos"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Nombre del grupo de subnets para la instancia de base de datos"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Clase de la instancia de base de datos"
}

variable "alb_arn" {
  type        = string
  description = "ARN del Application Load Balancer existente"
}

# Módulo principal del servicio de órdenes
module "orders_service" {
  source = "./modules/orders_service"

  service_name         = var.service_name
  environment          = var.environment
  instance_type        = var.instance_type
  min_size             = var.min_size
  max_size             = var.max_size
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  container_port       = var.container_port
  load_balancer_port   = var.load_balancer_port
  ecs_cluster_id       = var.ecs_cluster_id
  private_subnet_ids   = var.private_subnet_ids
  vpc_id               = var.vpc_id
  db_subnet_group_name = var.db_subnet_group_name
  db_instance_class    = var.db_instance_class
  alb_arn              = var.alb_arn
}