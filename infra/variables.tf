# Definición de variables para parametrizar el despliegue de la infraestructura AWS.
# Estas variables permiten personalizar el despliegue según el entorno (dev, prod, etc.).

# Ejemplo de variable para definir el entorno (dev, prod, staging)
variable "environment" {
  description = "Entorno en el que se desplegará la infraestructura (ej: dev, prod)"
  type        = string
  default     = "dev"
}

# Ejemplo de variable para definir la región de AWS
variable "aws_region" {
  description = "Región de AWS donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

# Variable para el nombre del servicio (ej: orders-service)
variable "service_name" {
  description = "Nombre del servicio para el que se despliega la infraestructura"
  type        = string
}

# Variable para el tamaño de la instancia EC2 (opcional)
variable "instance_type" {
  description = "Tipo de instancia EC2 para el servicio"
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

# Variable para el nombre de la base de datos (opcional)
variable "db_name" {
  description = "Nombre de la base de datos RDS"
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

# Variable para el puerto del contenedor
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