terraform {
  backend "s3" {
    bucket         = "${var.service_name}-terraform-state"
    key            = "environments/prod/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "${var.service_name}-terraform-locks"
  }
}