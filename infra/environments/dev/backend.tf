# STUB: Configuración del backend remoto para el entorno de desarrollo
# El participante configurará el backend S3 + DynamoDB para state compartido

terraform {
  backend "s3" {
    # Bucket debe ser creado previamente o configurarse manualmente
    bucket         = "terraform-state-${var.environment}-bucket"
    key            = "environments/dev/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

# Nota: El bucket S3 y la tabla DynamoDB deben existir antes de ejecutar
# terraform init. Se pueden crear manualmente o mediante un pipeline de bootstrapping.