# Salidas de Terraform que exponen información de la infraestructura desplegada
# Estos valores pueden ser utilizados por otros módulos o procesos de CI/CD

# Nombre del servicio de ECS
output "service_name" {
  description = "Nombre del servicio de ECS"
  value       = module.orders_service.ecs_service_name
}

# ID del cluster de ECS
output "ecs_cluster_id" {
  description = "ID del cluster de ECS"
  value       = module.orders_service.ecs_cluster_id
}

# ARN de la definición de tarea de ECS
output "task_definition_arn" {
  description = "ARN de la definición de tarea de ECS"
  value       = module.orders_service.ecs_task_definition_arn
}

# Familia de la definición de tarea de ECS
output "task_definition_family" {
  description = "Familia de la definición de tarea de ECS"
  value       = module.orders_service.ecs_task_definition_family
}

# Endpoint de la base de datos
output "database_endpoint" {
  description = "Endpoint de la instancia de base de datos"
  value       = module.orders_service.db_instance_endpoint
}

# Dirección de la base de datos
output "database_address" {
  description = "Dirección de la instancia de base de datos"
  value       = module.orders_service.db_instance_address
}

# Puerto de la base de datos
output "database_port" {
  description = "Puerto de la instancia de base de datos"
  value       = module.orders_service.db_instance_port
}

# ID de la base de datos
output "database_id" {
  description = "ID de la instancia de base de datos"
  value       = module.orders_service.db_instance_id
}

# URL de la cola SQS de órdenes
output "orders_queue_url" {
  description = "URL de la cola SQS de órdenes"
  value       = module.orders_service.sqs_queue_url
}

# ARN de la cola SQS de órdenes
output "orders_queue_arn" {
  description = "ARN de la cola SQS de órdenes"
  value       = module.orders_service.sqs_queue_arn
}

# URL de la cola SQS de mensajes fallidos
output "orders_dlq_url" {
  description = "URL de la cola SQS de mensajes fallidos"
  value       = module.orders_service.sqs_dlq_url
}

# ARN de la cola SQS de mensajes fallidos
output "orders_dlq_arn" {
  description = "ARN de la cola SQS de mensajes fallidos"
  value       = module.orders_service.sqs_dlq_arn
}

# ID del security group de ECS
output "ecs_security_group_id" {
  description = "ID del security group del servicio de ECS"
  value       = module.orders_service.ecs_security_group_id
}

# ID del security group de RDS
output "rds_security_group_id" {
  description = "ID del security group de la base de datos RDS"
  value       = module.orders_service.rds_security_group_id
}

# ARN del rol de ejecución de ECS
output "ecs_execution_role_arn" {
  description = "ARN del rol de ejecución de ECS"
  value       = module.orders_service.ecs_execution_role_arn
}

# ARN del rol de tarea de ECS
output "ecs_task_role_arn" {
  description = "ARN del rol de tarea de ECS"
  value       = module.orders_service.ecs_task_role_arn
}