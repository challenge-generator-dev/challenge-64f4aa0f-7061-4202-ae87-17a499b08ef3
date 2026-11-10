# =============================================================================
# Outputs del Módulo de Servicio de Órdenes
# Expone información crítica para consumo por otros módulos o entornos
# =============================================================================

output "ecs_cluster_id" {
  description = "ID del cluster ECS donde está desplegado el servicio"
  value       = var.ecs_cluster_id
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.orders_service.name
}

output "ecs_task_definition_arn" {
  description = "ARN de la task definition"
  value       = aws_ecs_task_definition.orders_service.arn
}

output "ecs_task_definition_family" {
  description = "Familia de la task definition"
  value       = aws_ecs_task_definition.orders_service.family
}

output "db_instance_endpoint" {
  description = "Endpoint de la instancia RDS"
  value       = aws_db_instance.orders_db.endpoint
}

output "db_instance_address" {
  description = "Dirección de la base de datos"
  value       = aws_db_instance.orders_db.address
}

output "db_instance_port" {
  description = "Puerto de la base de datos"
  value       = aws_db_instance.orders_db.port
}

output "db_instance_id" {
  description = "ID de la instancia RDS"
  value       = aws_db_instance.orders_db.id
}

output "sqs_queue_url" {
  description = "URL de la cola SQS principal"
  value       = aws_sqs_queue.orders_queue.url
}

output "sqs_queue_arn" {
  description = "ARN de la cola SQS principal"
  value       = aws_sqs_queue.orders_queue.arn
}

output "sqs_dlq_url" {
  description = "URL de la cola de mensajes fallidos"
  value       = aws_sqs_queue.orders_dlq.url
}

output "sqs_dlq_arn" {
  description = "ARN de la cola de mensajes fallidos"
  value       = aws_sqs_queue.orders_dlq.arn
}

output "ecs_security_group_id" {
  description = "ID del security group del servicio ECS"
  value       = aws_security_group.ecs_service.id
}

output "rds_security_group_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds.id
}

output "ecs_execution_role_arn" {
  description = "ARN del rol de ejecución de ECS"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN del rol de tareas de ECS"
  value       = aws_iam_role.ecs_task_role.arn
}