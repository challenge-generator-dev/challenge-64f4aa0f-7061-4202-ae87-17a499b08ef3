# Variables específicas para el entorno de producción
# Estas variables se utilizan en main.tf para configurar el módulo del servicio

variable "service_name" {
  type        = string
  description = "Nombre del servicio de órdenes"
}

variable "aws_region" {
  type        = string
  description = "Región de AWS"
  default     = "us-east-1"
}

variable "instance_type" {
  type        = string
  description = "Tipo de instancia EC2 para el cluster ECS"
  default     = "t3.small"
}

variable "min_size" {
  type        = number
  description = "Número mínimo de instancias en el Auto Scaling Group"
  default     = 2
}

variable "max_size" {
  type        = number
  description = "Número máximo de instancias en el Auto Scaling Group"
  default     = 5
}

variable "db_name" {
  type        = string
  description = "Nombre de la base de datos RDS"
  default     = "ordersdb_prod"
}

variable "db_username" {
  type        = string
  description = "Usuario de la base de datos"
}

variable "db_password" {
  type        = string
  description = "Contraseña de la base de datos"
  sensitive   = true
}

variable "container_port" {
  type        = number
  description = "Puerto del contenedor Docker"
  default     = 8080
}

variable "load_balancer_port" {
  type        = number
  description = "Puerto del balanceador de carga"
  default     = 80
}