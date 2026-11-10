# Variables específicas para el entorno de desarrollo
# Estas variables se utilizan en main.tf para configurar el módulo del servicio

variable "service_name" {
  type        = string
  description = "Nombre del servicio de órdenes"
  default     = "orders-service"
}

variable "environment" {
  type        = string
  description = "Entorno de despliegue"
  default     = "dev"
}

variable "instance_type" {
  type        = string
  description = "Tipo de instancia EC2 para el cluster ECS"
  default     = "t3.micro"
}

variable "min_size" {
  type        = number
  description = "Número mínimo de instancias en el Auto Scaling Group"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Número máximo de instancias en el Auto Scaling Group"
  default     = 3
}

variable "db_name" {
  type        = string
  description = "Nombre de la base de datos RDS"
  default     = "ordersdb"
}

variable "db_username" {
  type        = string
  description = "Usuario de la base de datos"
  default     = "admin"
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

variable "tags" {
  type        = map(string)
  description = "Etiquetas para los recursos"
  default = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

variable "aws_region" {
  type        = string
  description = "Región de AWS"
  default     = "us-east-1"
}