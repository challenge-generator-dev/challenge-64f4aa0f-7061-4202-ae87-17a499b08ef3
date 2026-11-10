# Variables específicas del módulo del servicio de órdenes.
# Estas variables permiten configurar los recursos específicos del servicio.

# Variable para el nombre del servicio
variable "service_name" {
  description = "Nombre del servicio de órdenes"
  type        = string
}

# Variable para el entorno (dev, prod, etc.)
variable "environment" {
  description = "Entorno en el que se desplegará el servicio"
  type        = string
}

# Variable para el tipo de instancia EC2
variable "instance_type" {
  description = "Tipo de instancia EC2 para el servicio de órdenes"
  type        = string
  default     = "t3.micro"
}

# Variable para el número mínimo de instancias en el Auto Scaling Group
variable "min_size" {
  description = "Número mínimo de instancias en el Auto Scaling Group"
  type        = number
  default     = 1
}

# Variable para el número máximo de instancias en el Auto Scaling Group
variable "max_size" {
  description = "Número máximo de instancias en el Auto Scaling Group"
  type        = number
  default     = 3
}

# Variable para el nombre de la base de datos
variable "db_name" {
  description = "Nombre de la base de datos RDS para el servicio de órdenes"
  type        = string
  default     = "ordersdb"
}

# Variable para el usuario de la base de datos
variable "db_username" {
  description = "Usuario de la base de datos RDS"
  type        = string
}

# Variable para la contraseña de la base de datos
variable "db_password" {
  description = "Contraseña de la base de datos RDS"
  type        = string
  sensitive   = true
}

# Variable para el puerto del contenedor (si aplica)
variable "container_port" {
  description = "Puerto del contenedor para el servicio"
  type        = number
  default     = 8080
}

# Variable para el puerto del balanceador de carga
variable "load_balancer_port" {
  description = "Puerto del balanceador de carga"
  type        = number
  default     = 80
}

# Variable para el ID del cluster de ECS
variable "ecs_cluster_id" {
  description = "ID del cluster de ECS donde se desplegará el servicio"
  type        = string
}

# Variable para los IDs de las subredes privadas
variable "private_subnet_ids" {
  description = "IDs de las subredes privadas donde se desplegarán los recursos"
  type        = list(string)
}

# Variable para el ID de la VPC
variable "vpc_id" {
  description = "ID de la VPC donde se desplegarán los recursos"
  type        = string
}

# Variable para la clase de instancia de la base de datos
variable "db_instance_class" {
  description = "Clase de instancia de la base de datos RDS"
  type        = string
  default     = "db.t3.micro"
}

# Variable para el nombre del grupo de subredes de la base de datos
variable "db_subnet_group_name" {
  description = "Nombre del grupo de subredes de la base de datos RDS"
  type        = string
}