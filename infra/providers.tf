# Provider de AWS para Terraform
# Configura la conexión con AWS usando las credenciales configuradas en el entorno.
# Se especifica la región y la versión del provider para asegurar compatibilidad.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.65.0"
    }
  }
  required_version = ">= 1.9.0"
}

provider "aws" {
  region = "us-east-1" # Región por defecto, se puede sobrescribir con variables
}