environment        = "dev"
aws_region         = "us-east-1"
service_name       = "orders-service"
instance_type      = "t3.micro"
min_size           = 1
max_size           = 2
db_name            = "ordersdb_dev"
db_username        = "dbadmin"
db_password        = "DevPassword2024!"
container_port     = 8080
load_balancer_port = 80

tags = {
  Environment = "development"
  Project     = "orders-platform"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
  Team        = "platform"
}

vpc_cidr_block        = "10.0.0.0/16"
public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs  = ["10.0.10.0/24", "10.0.20.0/24"]
database_subnet_cidrs = ["10.0.100.0/24", "10.0.110.0/24"]

enable_deletion_protection = false
enable_monitoring          = true
enable_logging             = true
log_retention_days         = 7

db_allocated_storage     = 20
db_storage_encrypted     = true
db_backup_retention_days = 1
db_skip_final_snapshot   = true

asg_health_check_type         = "ELB"
asg_health_check_grace_period = 60
asg_termination_policies      = ["OldestInstance"]

enable_s3_bucket     = true
s3_bucket_name       = "orders-service-dev-assets"
s3_enable_versioning = true
s3_enable_encryption = true

enable_cloudwatch_alarms      = true
alarm_cpu_threshold           = 75
alarm_memory_threshold        = 80
alarm_request_count_threshold = 1000