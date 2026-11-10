# Configuración específica para el entorno de producción
# El participante implementará la composición de módulos aquí

terraform {
  # El backend se configura en backend.tf
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
  default     = "db.t3.small"
  description = "Clase de la instancia de base de datos"
}

variable "alb_arn" {
  type        = string
  description = "ARN del Application Load Balancer existente"
}

module "orders_service" {
  source = "../../modules/orders_service"

  service_name         = var.service_name
  environment          = "prod"
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

// Outputs para el entorno de producción
output "service_endpoint" {
  description = "Endpoint del servicio de órdenes en producción"
  value       = "https://${module.orders_service.ecs_service_name}.${module.orders_service.ecs_cluster_id}"
}

output "service_arn" {
  description = "ARN del servicio de órdenes"
  value       = module.orders_service.ecs_task_definition_arn
}

output "database_endpoint" {
  description = "Endpoint de la base de datos"
  value       = module.orders_service.db_instance_endpoint
}

output "orders_queue_url" {
  description = "URL de la cola de órdenes"
  value       = module.orders_service.sqs_queue_url
}

output "orders_queue_arn" {
  description = "ARN de la cola de órdenes"
  value       = module.orders_service.sqs_queue_arn
}