# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/orders_service/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/dev/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/dev/backend.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/prod/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/environments/prod/backend.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `api` | `api/` | chapter, support | server | Java | - |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd api && mvn clean compile` — componente `api` (chapter, support).

### Contratos entre componentes

- `api` expone http (api: http://localhost:8080):
  - `POST /api/orders`
  - `GET /api/orders/{id}`

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).
- **Java**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `api/src/main/java/com/orders/api/infrastructure/web/OrderController.java` — `OrderItemDto`: OrderItemDto se usa en el cuerpo del archivo pero no esta importado. El proyecto lo declara en com.orders.api.application.OrderItemDto.
- `api/src/main/java/com/orders/api/application/OrderService.java` — `OrderItem.price`: Se invoca `price` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orders/api/application/OrderService.java` — `OrderItem.quantity`: Se invoca `quantity` sobre `OrderItem`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `api/src/main/java/com/orders/api/infrastructure/web/OrderController.java` — `OrderRequest.items`: Se invoca `items` sobre `OrderRequest`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform (corrida e2e 20261110115758191), Aprovisiona con Terraform la infraestructura AWS que necesita el servicio de ordenes

### Misión / candidato
Versionar la infraestructura del servicio

### Reto
- Tema: Infraestructura como codigo para el servicio de ordenes
- Seniority: senior-l2
- Tipo: practical
- Título: Versionado de Infraestructura con Terraform para el Servicio de Órdenes
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración Inicial de Terraform — objetivo: Configurar el entorno de Terraform para la gestión de la infraestructura AWS. — entregable (NO resolver): Configuración de Terraform lista para el despliegue de la infraestructura.
- Fase 2: Despliegue de la Infraestructura AWS — objetivo: Desplegar la infraestructura necesaria para el servicio de órdenes utilizando Terraform. — entregable (NO resolver): Infraestructura AWS desplegada y versionada utilizando Terraform.
- Fase 3: Versionado y Gestión de la Infraestructura — objetivo: Versionar y gestionar la infraestructura desplegada utilizando Terraform. — entregable (NO resolver): Proceso documentado para versionar y actualizar la infraestructura utilizando Terraform.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/providers.tf ===
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

// === ARCHIVO: infra/variables.tf ===
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

// === ARCHIVO: infra/modules/orders_service/variables.tf ===
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

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
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

// === ARCHIVO: infra/environments/dev/main.tf ===
# Configuración específica para el entorno de desarrollo
# El participante implementará la composición de módulos aquí

terraform {
  # El backend se configura en backend.tf
  # Las variables se cargan desde terraform.tfvars
}

# Variables requeridas para el módulo de orders_service
variable "ecs_cluster_id" {
  type        = string
  description = "ID del cluster ECS donde se desplegará el servicio"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs de las subnets privadas donde se desplegarán los recursos"
}

variable "vpc_id" {
  type        = string
  description = "ID de la VPC donde se crearán los recursos"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Nombre del grupo de subnets para la instancia de base de datos"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Clase de la instancia de base de datos"
}

variable "alb_arn" {
  type        = string
  description = "ARN del Application Load Balancer existente"
}

# Referencia al módulo del servicio de órdenes
module "orders_service" {
  source = "../../modules/orders_service"

  service_name         = var.service_name
  environment          = var.environment
  instance_type        = var.instance_type
  min_size             = var.min_size
  max_size             = var.max_size
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  container_port       = var.container_port
  load_balancer_port   = var.load_balancer_port
  ecs_cluster_id       = var.ecs_cluster_id
  private_subnet_ids   = var.private_subnet_ids
  vpc_id               = var.vpc_id
  db_subnet_group_name = var.db_subnet_group_name
  db_instance_class    = var.db_instance_class
  alb_arn              = var.alb_arn
}

# Outputs locales para el entorno de desarrollo
output "service_endpoint" {
  description = "Endpoint del servicio de órdenes en desarrollo"
  value       = "http://${module.orders_service.ecs_service_name}.${module.orders_service.ecs_cluster_id}"
}

output "service_arn" {
  description = "ARN del servicio de órdenes"
  value       = module.orders_service.ecs_task_definition_arn
}

output "database_endpoint" {
  description = "Endpoint de la base de datos"
  value       = module.orders_service.db_instance_endpoint
}

output "orders_queue_url" {
  description = "URL de la cola de órdenes"
  value       = module.orders_service.sqs_queue_url
}

output "orders_queue_arn" {
  description = "ARN de la cola de órdenes"
  value       = module.orders_service.sqs_queue_arn
}

// === ARCHIVO: infra/environments/dev/backend.tf ===
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

// === ARCHIVO: infra/environments/prod/backend.tf ===
terraform {
  backend "s3" {
    bucket         = "${var.service_name}-terraform-state"
    key            = "environments/prod/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "${var.service_name}-terraform-locks"
  }
}

// === ARCHIVO: infra/environments/prod/main.tf ===
# Configuración específica para el entorno de producción
# El participante implementará la composición de módulos aquí

terraform {
  # El backend se configura en backend.tf
}

# Variables requeridas para el módulo de orders_service
variable "ecs_cluster_id" {
  type        = string
  description = "ID del cluster ECS donde se desplegará el servicio"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs de las subnets privadas donde se desplegarán los recursos"
}

variable "vpc_id" {
  type        = string
  description = "ID de la VPC donde se crearán los recursos"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Nombre del grupo de subnets para la instancia de base de datos"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.small"
  description = "Clase de la instancia de base de datos"
}

variable "alb_arn" {
  type        = string
  description = "ARN del Application Load Balancer existente"
}

module "orders_service" {
  source = "../../modules/orders_service"

  service_name         = var.service_name
  environment          = "prod"
  instance_type        = var.instance_type
  min_size             = var.min_size
  max_size             = var.max_size
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  container_port       = var.container_port
  load_balancer_port   = var.load_balancer_port
  ecs_cluster_id       = var.ecs_cluster_id
  private_subnet_ids   = var.private_subnet_ids
  vpc_id               = var.vpc_id
  db_subnet_group_name = var.db_subnet_group_name
  db_instance_class    = var.db_instance_class
  alb_arn              = var.alb_arn
}

// Outputs para el entorno de producción
output "service_endpoint" {
  description = "Endpoint del servicio de órdenes en producción"
  value       = "https://${module.orders_service.ecs_service_name}.${module.orders_service.ecs_cluster_id}"
}

output "service_arn" {
  description = "ARN del servicio de órdenes"
  value       = module.orders_service.ecs_task_definition_arn
}

output "database_endpoint" {
  description = "Endpoint de la base de datos"
  value       = module.orders_service.db_instance_endpoint
}

output "orders_queue_url" {
  description = "URL de la cola de órdenes"
  value       = module.orders_service.sqs_queue_url
}

output "orders_queue_arn" {
  description = "ARN de la cola de órdenes"
  value       = module.orders_service.sqs_queue_arn
}

// === ARCHIVO: infra/modules/orders_service/main.tf ===
# =============================================================================
# Recursos AWS para el Servicio de Órdenes
# Este módulo define la infraestructura necesaria para desplegar el servicio
# =============================================================================

variable "alb_arn" {
  type        = string
  description = "ARN del Application Load Balancer al que conectar el listener"
}

# ECS Task Definition para el servicio de órdenes
resource "aws_ecs_task_definition" "orders_service" {
  family                   = "${var.service_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = var.service_name
      image     = "${var.service_name}:latest"
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "ENVIRONMENT", value = var.environment }
      ]
    }
  ])
}

# Target Group para el Application Load Balancer
# TODO(reto): Configurar health check path y otros parámetros según requisitos del servicio
resource "aws_lb_target_group" "orders" {
  name     = "${var.service_name}-tg"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/actuator/health"
    matcher             = "200"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Listener para el Application Load Balancer
# TODO(reto): Configurar reglas de routing y condiciones según requisitos del servicio
resource "aws_lb_listener" "orders" {
  load_balancer_arn = var.alb_arn
  port              = var.load_balancer_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orders.arn
  }
}

# ECS Service para el servicio de órdenes
resource "aws_ecs_service" "orders_service" {
  name            = var.service_name
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.orders_service.arn
  desired_count   = var.min_size
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = [aws_security_group.ecs_service.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.orders.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.orders]

  lifecycle {
    create_before_destroy = true
  }
}

# Security Group para el servicio ECS
resource "aws_security_group" "ecs_service" {
  name        = "${var.service_name}-sg"
  description = "Security group para el servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Instance para la base de datos de órdenes
resource "aws_db_instance" "orders_db" {
  identifier     = "${var.service_name}-db"
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = var.db_instance_class

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = var.db_subnet_group_name

  backup_retention_period = 7
  skip_final_snapshot     = var.environment != "prod"
  deletion_protection     = var.environment == "prod"
}

# Security Group para RDS
resource "aws_security_group" "rds" {
  name        = "${var.service_name}-rds-sg"
  description = "Security group para RDS del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_service.id]
  }
}

# SQS Queue para procesamiento de órdenes
resource "aws_sqs_queue" "orders_queue" {
  name                      = "${var.service_name}-queue"
  message_retention_seconds = 345600
  max_message_size          = 262144
  delay_seconds             = 0
  receive_wait_time_seconds = 20

  tags = {
    Environment = var.environment
    Service     = var.service_name
  }
}

# Dead Letter Queue para mensajes fallidos
resource "aws_sqs_queue" "orders_dlq" {
  name                      = "${var.service_name}-dlq"
  message_retention_seconds = 1209600
  max_message_size          = 262144

  tags = {
    Environment = var.environment
    Service     = var.service_name
  }
}

# IAM Role para ejecución de tareas ECS
resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.service_name}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# IAM Role para tareas ECS
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.service_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Policy para acceso a SQS
resource "aws_iam_policy" "sqs_access_policy" {
  name        = "${var.service_name}-sqs-access"
  description = "Permite acceso a la cola SQS del servicio de órdenes"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:SendMessage"
        ]
        Resource = aws_sqs_queue.orders_queue.arn
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = aws_sqs_queue.orders_dlq.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_sqs_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.sqs_access_policy.arn
}

// === ARCHIVO: infra/modules/orders_service/outputs.tf ===
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

// === ARCHIVO: infra/.gitignore ===
# Terraform local state and logs
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
crash.log
crash.*.log
*.log

# Terraform directory
.terraform/
.terraform.lock.hcl
*.lock
*.lock.*

# Sensitive variable overrides (never commit real credentials)
*_override.tf
*_override.tf.json

# IDE and editor files
.vscode/
.idea/
*.swp
*.swo
*~

# OS generated files
.DS_Store
Thumbs.db

# Backup files
*.bak
*.backup

# Environment specific files (use .tfvars files in environments/ instead)
# These patterns ensure secrets are not accidentally committed
env-secret.tfvars
*secret*.tfvars
*password*.tfvars
*credential*.tfvars

// === ARCHIVO: infra/README.md ===
# Infraestructura como Código - Servicio de Órdenes

Este proyecto contiene la definición de infraestructura como código utilizando Terraform para el servicio de gestión de órdenes en la plataforma de comercio electrónico.

## Propósito

El objetivo de este proyecto es versionar y gestionar la infraestructura AWS requerida por el servicio de órdenes de manera automatizada, reproducible y controlada mediante versiones. La infraestructura incluye recursos computacionales, bases de datos, balanceadores de carga y componentes de red necesarios para el funcionamiento del servicio.

## Arquitectura General

El proyecto sigue una estructura modular que separa la configuración en diferentes entornos y componentes reutilizables. Esta separación permite gestionar la infraestructura de manera independiente para cada ambiente (desarrollo, producción) mientras se promueve la reutilización de componentes comunes.

### Estructura de Directorios

```
infra/
├── environments/          # Configuraciones específicas por entorno
│   ├── dev/              # Entorno de desarrollo
│   └── prod/             # Entorno de producción
├── modules/              # Módulos reutilizables
│   └── orders_service/   # Módulo del servicio de órdenes
├── providers.tf          # Configuración de proveedores
├── variables.tf          # Variables globales
├── versions.tf           # Requisitos de versión de Terraform
├── main.tf               # Orquestación principal
├── outputs.tf            # Outputs globales
└── .gitignore           # Archivos ignorados por Git
```

## Requisitos Previos

Para trabajar con este proyecto se necesitan las siguientes herramientas instaladas y configuradas correctamente. La versión de Terraform debe ser igual o superior a la especificada en el archivo versions.tf para garantizar la compatibilidad con todas las funcionalidades utilizadas.

La CLI de AWS debe estar configurada con credenciales válidas que tengan los permisos necesarios para crear y gestionar los recursos definidos en los módulos. Se recomienda utilizar IAM Roles en lugar de claves de acceso directas para entornos de producción.

## Configuración Inicial

Antes de ejecutar cualquier comando de Terraform es necesario inicializar el backend remoto y descargar los proveedores necesarios. Este paso debe realizarse una vez por entorno y cada vez que se agreguen nuevos proveedores o módulos.

Para inicializar un entorno específico, navegue al directorio correspondiente y ejecute los comandos de inicialización. El backend remoto está configurado para utilizar S3 como almacenamiento de estado y DynamoDB para el bloqueo de estado, lo que permite el trabajo colaborativo seguro.

## Comandos de Uso

El flujo de trabajo típico con Terraform sigue los pasos de planificación, revisión y aplicación. Siempre revise el plan antes de aplicar cambios para evitar modificaciones no deseadas en la infraestructura.

### Planificar Cambios

El comando plan genera un plan de ejecución que muestra las acciones que Terraform realizará sobre la infraestructura existente. Este paso es seguro porque no modifica ningún recurso real.

### Aplicar Cambios

Una vez revisado y aprobado el plan, se aplica con el comando apply. Terraform mostrará nuevamente el plan y solicitará confirmación antes de proceder con la creación, modificación o eliminación de recursos.

### Destruir Infraestructura

Para eliminar todos los recursos gestionados por Terraform, utilice el comando destroy. Este comando debe usarse con extrema precaución en entornos de producción.

## Gestión de Secretos

Las credenciales sensibles como contraseñas de base de datos y claves de API nunca deben incluirse en archivos versionados. Utilice variables de entorno o archivos .tfvars externos que estén excluidos del control de versiones mediante el .gitignore.

Los valores sensibles también pueden almacenarse en AWS Secrets Manager o HashiCorp Vault para entornos de producción, integrándolos medianteData Sources de Terraform.

## Versionado y Workflow

La infraestructura sigue un flujo de trabajo de GitOps donde los cambios en el código de Terraform pasan por un proceso de revisión antes de ser aplicados. Cada cambio debe incluir una descripción clara del propósito y los recursos afectados.

Se recomienda utilizar workspaces de Terraform para gestionar diferentes versiones de la infraestructura dentro del mismo directorio de configuración, aunque también es válido mantener directorios separados por entorno como se muestra en este proyecto.

## Módulo orders_service

El módulo principal del servicio de órdenes encapsula todos los recursos necesarios para ejecutar el servicio. Incluye la definición de instancias EC2 o contenedores, la base de datos PostgreSQL, el balanceador de carga y la configuración de red necesaria para la comunicación entre componentes.

El módulo está diseñado para ser parametrizable mediante variables que permiten ajustar el tamaño de la infraestructura, las credenciales de la base de datos y los puertos de comunicación sin modificar el código interno del módulo.

## Outputs Principales

Una vez aplicada la configuración, Terraform expone información importante como el endpoint del balanceador de carga, el ARN de la base de datos y las URLs de los servicios. Estos valores pueden ser utilizados por otros sistemas de despliegue o documentación.

## Consideraciones de Seguridad

Todos los recursos de producción deben estar configurados con encryption habilitada, tanto en reposo como en tránsito. Los grupos de seguridad deben seguir el principio de mínimo privilegio, permitiendo únicamente el tráfico necesario.

Los logs de Terraform contienen información sensible y deben manejarse accordingly. El estado remoto en S3 debe tener versioning habilitado y preferiblemente server-side encryption.

## Soporte y Contribuciones

Para reportar problemas o solicitar cambios en la infraestructura, cree un issue en el repositorio del proyecto con una descripción detallada del problema o la mejora propuesta. Cualquier cambio en la infraestructura debe ser aprobado mediante revisión de código antes de ser aplicado.

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0"
}

// === ARCHIVO: infra/main.tf ===
# Configuración principal de Terraform para el servicio de órdenes
# Este archivo orchestra el despliegue de la infraestructura AWS

terraform {
  backend "s3" {
    bucket         = "terraform-state-${var.service_name}"
    key            = "infra/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

# Variables requeridas para el módulo de orders_service
variable "ecs_cluster_id" {
  type        = string
  description = "ID del cluster ECS donde se desplegará el servicio"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs de las subnets privadas donde se desplegarán los recursos"
}

variable "vpc_id" {
  type        = string
  description = "ID de la VPC donde se crearán los recursos"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Nombre del grupo de subnets para la instancia de base de datos"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Clase de la instancia de base de datos"
}

variable "alb_arn" {
  type        = string
  description = "ARN del Application Load Balancer existente"
}

# Módulo principal del servicio de órdenes
module "orders_service" {
  source = "./modules/orders_service"

  service_name         = var.service_name
  environment          = var.environment
  instance_type        = var.instance_type
  min_size             = var.min_size
  max_size             = var.max_size
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  container_port       = var.container_port
  load_balancer_port   = var.load_balancer_port
  ecs_cluster_id       = var.ecs_cluster_id
  private_subnet_ids   = var.private_subnet_ids
  vpc_id               = var.vpc_id
  db_subnet_group_name = var.db_subnet_group_name
  db_instance_class    = var.db_instance_class
  alb_arn              = var.alb_arn
}

// === ARCHIVO: infra/outputs.tf ===
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

// === ARCHIVO: infra/environments/dev/variables.tf ===
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

// === ARCHIVO: infra/environments/prod/variables.tf ===
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

// === ARCHIVO: api/pom.xml ===
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.5.6</version>
        <relativePath/>
    </parent>

    <groupId>com.orders</groupId>
    <artifactId>api</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>orders-api</name>
    <description>Servicio de gestión de órdenes</description>

    <properties>
        <java.version>21</java.version>
        <aws.sdk.version>1.12.760</aws.sdk.version>
        <postgresql.version>42.7.3</postgresql.version>
    </properties>

    <dependencies>
        <!-- Spring Boot Starters -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.flywaydb</groupId>
            <artifactId>flyway-core</artifactId>
        </dependency>

        <!-- AWS SDK -->
        <dependency>
            <groupId>com.amazonaws</groupId>
            <artifactId>aws-java-sdk-sqs</artifactId>
            <version>${aws.sdk.version}</version>
        </dependency>
        <dependency>
            <groupId>com.amazonaws</groupId>
            <artifactId>aws-java-sdk-dynamodb</artifactId>
            <version>${aws.sdk.version}</version>
        </dependency>

        <!-- PostgreSQL -->
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <version>${postgresql.version}</version>
            <scope>runtime</scope>
        </dependency>

        <!-- Test -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>

    <repositories>
        <repository>
            <id>spring-milestones</id>
            <name>Spring Milestones</name>
            <url>https://repo.spring.io/milestone</url>
        </repository>
    </repositories>
</project>

// === ARCHIVO: api/src/main/resources/application.yml ===
spring:
  application:
    name: orders-api
  
  datasource:
    url: jdbc:postgresql://localhost:5432/orders_db
    username: ${DB_USERNAME:orders_user}
    password: ${DB_PASSWORD:orders_password}
    driver-class-name: org.postgresql.Driver
    
  jpa:
    hibernate:
      ddl-auto: validate
    open-in-view: false
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true
    
  flyway:
    enabled: true
    locations: classpath:db/migration
    baseline-on-migrate: true

server:
  port: 8080
  servlet:
    context-path: /api

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics

aws:
  region: ${AWS_REGION:us-east-1}
  sqs:
    order-events-queue: ${AWS_SQS_ORDER_EVENTS_QUEUE:order-events-queue}
  dynamodb:
    orders-table: ${AWS_DYNAMODB_ORDERS_TABLE:orders}

// === ARCHIVO: api/src/main/java/com/orders/api/domain/Order.java ===
package com.orders.api.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @NotNull
    @Positive
    @Column(nullable = false)
    private BigDecimal totalAmount;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private OrderStatus status;

    @NotNull
    @Column(nullable = false)
    private LocalDateTime createdAt;

    @NotNull
    @Column(nullable = false)
    private LocalDateTime updatedAt;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItem> items;

    @Version
    private Integer version;

    public Order() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.status = OrderStatus.PENDING;
    }

    public Order(BigDecimal totalAmount, List<OrderItem> items) {
        this();
        this.totalAmount = totalAmount;
        this.items = items;
        if (items != null) {
            items.forEach(item -> item.setOrder(this));
        }
    }

    public UUID getId() {
        return id;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public OrderStatus getStatus() {
        return status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
        this.updatedAt = LocalDateTime.now();
    }

    public void addItem(OrderItem item) {
        if (items == null) {
            items = new java.util.ArrayList<>();
        }
        items.add(item);
        item.setOrder(this);
        this.totalAmount = items.stream()
                .map(OrderItem::getPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    public enum OrderStatus {
        PENDING,
        PROCESSING,
        COMPLETED,
        CANCELLED
    }
}

// === ARCHIVO: api/src/main/java/com/orders/api/domain/OrderItem.java ===
package com.orders.api.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.util.UUID;

@Entity
@Table(name = "order_items")
public class OrderItem {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @NotNull
    @Positive
    @Column(nullable = false)
    private Integer quantity;

    @NotNull
    @Positive
    @Column(nullable = false)
    private BigDecimal price;

    @NotBlank
    @Size(max = 255)
    @Column(nullable = false)
    private String productId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;

    public OrderItem() {
    }

    public OrderItem(Integer quantity, BigDecimal price, String productId) {
        this.quantity = quantity;
        this.price = price;
        this.productId = productId;
    }

    public UUID getId() {
        return id;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public String getProductId() {
        return productId;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }
}

// === ARCHIVO: api/src/main/java/com/orders/api/domain/OrderRepository.java ===
package com.orders.api.domain;

import java.util.Optional;
import java.util.UUID;

public interface OrderRepository {
    Order save(Order order);
    Optional<Order> findById(UUID id);
    void deleteById(UUID id);
}

// === ARCHIVO: api/src/main/java/com/orders/api/application/OrderService.java ===
package com.orders.api.application;

import com.orders.api.domain.Order;
import com.orders.api.domain.OrderItem;
import com.orders.api.domain.OrderRepository;
import com.orders.api.domain.Order.OrderStatus;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderService {

    private static final Logger logger = LoggerFactory.getLogger(OrderService.class);
    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    @Transactional
    public Order createOrder(List<OrderItemDto> items) {
        logger.info("Creando nueva orden con {} items", items.size());

        BigDecimal totalAmount = items.stream()
            .map(item -> item.price().multiply(BigDecimal.valueOf(item.quantity())))
            .reduce(BigDecimal.ZERO, BigDecimal::add);

        Order order = new Order(totalAmount, new ArrayList<>());

        for (OrderItemDto itemDto : items) {
            OrderItem item = new OrderItem(
                itemDto.quantity(),
                itemDto.price(),
                itemDto.productId()
            );
            order.addItem(item);
        }

        Order savedOrder = orderRepository.save(order);
        logger.info("Orden creada exitosamente con ID: {}", savedOrder.getId());
        return savedOrder;
    }

    @Transactional(readOnly = true)
    public Optional<Order> getOrder(UUID id) {
        logger.info("Consultando orden con ID: {}", id);
        return orderRepository.findById(id);
    }

    @Transactional
    public void cancelOrder(UUID id) {
        logger.info("Cancelando orden con ID: {}", id);
        Optional<Order> orderOpt = orderRepository.findById(id);
        if (orderOpt.isEmpty()) {
            throw new IllegalArgumentException("Orden no encontrada: " + id);
        }
        Order order = orderOpt.get();
        order.setStatus(OrderStatus.CANCELLED);
        orderRepository.save(order);
        logger.info("Orden cancelada exitosamente");
    }

    public record OrderItemDto(Integer quantity, BigDecimal price, String productId) {}
}

// === ARCHIVO: api/src/main/java/com/orders/api/infrastructure/web/OrderController.java ===
package com.orders.api.infrastructure.web;

import com.orders.api.application.OrderService;
import com.orders.api.domain.Order;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<OrderResponse> createOrder(@Valid @RequestBody OrderRequest request) {
        logger.info("Recibida solicitud para crear orden con {} items", request.items().size());
        List<OrderService.OrderItemDto> itemDtos = request.items().stream()
            .map(item -> new OrderService.OrderItemDto(
                item.quantity(),
                item.price(),
                item.productId()))
            .toList();

        Order order = orderService.createOrder(itemDtos);
        OrderResponse response = toResponse(order);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponse> getOrder(@PathVariable UUID id) {
        logger.info("Consultando orden con ID: {}", id);
        return orderService.getOrder(id)
            .map(order -> ResponseEntity.ok(toResponse(order)))
            .orElse(ResponseEntity.notFound().build());
    }

    private OrderResponse toResponse(Order order) {
        List<OrderItemResponse> itemResponses = order.getItems().stream()
            .map(item -> new OrderItemResponse(
                item.getId(),
                item.getProductId(),
                item.getQuantity(),
                item.getPrice()))
            .toList();

        return new OrderResponse(
            order.getId(),
            order.getTotalAmount(),
            order.getStatus().name(),
            order.getCreatedAt(),
            order.getUpdatedAt(),
            itemResponses);
    }

    public record OrderRequest(
        @NotEmpty(message = "La orden debe contener al menos un item")
        List<OrderItemRequest> items) {}

    public record OrderItemRequest(
        @NotNull @Positive Integer quantity,
        @NotNull @Positive BigDecimal price,
        @NotBlank String productId) {}

    public record OrderResponse(
        UUID id,
        BigDecimal totalAmount,
        String status,
        LocalDateTime createdAt,
        LocalDateTime updatedAt,
        List<OrderItemResponse> items) {}

    public record OrderItemResponse(
        UUID id,
        String productId,
        Integer quantity,
        BigDecimal price) {}
}

// === ARCHIVO: api/src/main/java/com/orders/api/infrastructure/config/AwsConfig.java ===
package com.orders.api.infrastructure.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

@Configuration
@Profile("!test")
public class AwsConfig {

    private static final Logger logger = LoggerFactory.getLogger(AwsConfig.class);

    @Value("${AWS_ACCESS_KEY_ID:}")
    private String accessKeyId;

    @Value("${AWS_SECRET_ACCESS_KEY:}")
    private String secretAccessKey;

    @Value("${AWS_REGION:us-east-1}")
    private String region;

    @Value("${AWS_SQS_ENDPOINT:}")
    private String sqsEndpoint;

    @Value("${AWS_DYNAMODB_ENDPOINT:}")
    private String dynamoDbEndpoint;

    @Bean
    public AmazonSQS amazonSQS() {
        logger.info("Configurando cliente SQS para la región: {}", region);

        BasicAWSCredentials credentials = new BasicAWSCredentials(accessKeyId, secretAccessKey);
        AmazonSQSClientBuilder builder = AmazonSQSClientBuilder.standard()
            .withRegion(region)
            .withCredentials(new AWSStaticCredentialsProvider(credentials));

        if (sqsEndpoint != null && !sqsEndpoint.isBlank()) {
            logger.info("Usando endpoint personalizado para SQS: {}", sqsEndpoint);
            builder.withEndpointConfiguration(
                new AwsClientBuilder.EndpointConfiguration(sqsEndpoint, region));
        }

        return builder.build();
    }

    @Bean
    public AmazonDynamoDB amazonDynamoDB() {
        logger.info("Configurando cliente DynamoDB para la región: {}", region);

        BasicAWSCredentials credentials = new BasicAWSCredentials(accessKeyId, secretAccessKey);
        AmazonDynamoDBClientBuilder builder = AmazonDynamoDBClientBuilder.standard()
            .withRegion(region)
            .withCredentials(new AWSStaticCredentialsProvider(credentials));

        if (dynamoDbEndpoint != null && !dynamoDbEndpoint.isBlank()) {
            logger.info("Usando endpoint personalizado para DynamoDB: {}", dynamoDbEndpoint);
            builder.withEndpointConfiguration(
                new AwsClientBuilder.EndpointConfiguration(dynamoDbEndpoint, region));
        }

        return builder.build();
    }
}

// === ARCHIVO: api/src/main/resources/db/migration/V1__Create_orders_table.sql ===
-- ============================================================
-- Script de migración Flyway para crear la estructura de tablas
-- del servicio de gestión de órdenes
-- Versión: 1
-- Fecha de creación: 2024-01-01
-- Descripción: Crea las tablas orders y order_items con sus
--              índices y restricciones necesarias
-- ============================================================

-- Tabla principal de órdenes
CREATE TABLE orders (
    id UUID PRIMARY KEY NOT NULL,
    total_amount NUMERIC(19, 4) NOT NULL CHECK (total_amount >= 0),
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    version INTEGER NOT NULL DEFAULT 0
);

-- Tabla de elementos de orden (relación uno a muchos)
CREATE TABLE order_items (
    id UUID PRIMARY KEY NOT NULL,
    order_id UUID NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price NUMERIC(19, 4) NOT NULL CHECK (price >= 0),
    product_id VARCHAR(255) NOT NULL
);

-- Restricción de clave foránea para la relación orden-items
ALTER TABLE order_items
ADD CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id)
REFERENCES orders(id)
ON DELETE CASCADE
ON UPDATE NO ACTION;

-- Índice para buscar órdenes por estado
CREATE INDEX idx_orders_status ON orders(status);

-- Índice para buscar órdenes por fecha de creación
CREATE INDEX idx_orders_created_at ON orders(created_at);

-- Índice para buscar items de orden por ID de orden
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- Índice para buscar items de orden por ID de producto
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Comentario sobre la tabla de órdenes
COMMENT ON TABLE orders IS 'Almacena las órdenes del sistema de comercio electrónico';

-- Comentario sobre la tabla de items
COMMENT ON TABLE order_items IS 'Almacena los productos asociados a cada orden';

-- Comentario sobre la columna de estado
COMMENT ON COLUMN orders.status IS 'Estado de la orden: PENDING, CONFIRMED, PROCESSING, SHIPPED, DELIVERED, CANCELLED';

-- Comentario sobre la columna de versión para optimistic locking
COMMENT ON COLUMN orders.version IS 'Número de versión para control de concurrencia optimistic locking';

-- Verificar que la tabla fue creada correctamente
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'orders') THEN
        RAISE EXCEPTION 'La tabla orders no fue creada correctamente';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'order_items') THEN
        RAISE EXCEPTION 'La tabla order_items no fue creada correctamente';
    END IF;
    RAISE NOTICE 'Migración V1 completada exitosamente: tablas orders y order_items creadas';
END $$;

// === ARCHIVO: api/src/main/java/com/orders/api/Application.java ===
package com.orders.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import java.net.InetAddress;
import java.util.Arrays;
import java.util.UUID;

@SpringBootApplication
@ConfigurationPropertiesScan
public class Application {

    private static final Logger logger = LoggerFactory.getLogger(Application.class);

    public static void main(String[] args) {
        try {
            SpringApplication app = new SpringApplication(Application.class);
            app.setAdditionalProfiles("default");
            var environment = app.run(args).getEnvironment();
            logApplicationStartup(environment);
        } catch (Exception e) {
            logger.error("La aplicación no pudo iniciar correctamente", e);
            System.exit(1);
        }
    }

    private static void logApplicationStartup(org.springframework.core.env.Environment environment) {
        String protocol = "http";
        String serverPort = environment.getProperty("server.port", "8080");
        String contextPath = environment.getProperty("server.servlet.context-path", "/");
        String hostAddress = "localhost";
        try {
            InetAddress inetAddress = InetAddress.getLocalHost();
            hostAddress = inetAddress.getHostAddress();
        } catch (Exception e) {
            logger.warn("No se pudo determinar la dirección del host", e);
        }
        logger.info("\n----------------------------------------------------------\n\t" +
                "Aplicación '{}' iniciada en {}\n\t" +
                "Perfiles activos: {}\n\t" +
                "URL externa: {}://{}:{}{}proxy/actuator/health\n\t" +
                "Documentación Swagger: {}://{}:{}{}proxy/swagger-ui.html\n" +
                "----------------------------------------------------------",
                environment.getProperty("spring.application.name", "orders-api"),
                environment.getProperty("spring.profiles.active", "default"),
                Arrays.toString(environment.getActiveProfiles()),
                protocol, hostAddress, serverPort, contextPath,
                protocol, hostAddress, serverPort, contextPath);
    }

    @Bean
    @Profile("!test")
    public ApplicationProperties applicationProperties() {
        return new ApplicationProperties();
    }

    @Bean
    @Profile("!test")
    public DataSourceConfiguration dataSourceConfiguration() {
        return new DataSourceConfiguration();
    }

    @Configuration
    @ConfigurationProperties(prefix = "application")
    public static class ApplicationProperties {
        private String name = "orders-api";
        private String version = "1.0.0";
        private String description = "Servicio de gestión de órdenes";

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getVersion() {
            return version;
        }

        public void setVersion(String version) {
            this.version = version;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }
    }

    @Configuration
    public static class DataSourceConfiguration {
        private static final Logger log = LoggerFactory.getLogger(DataSourceConfiguration.class);

        @Bean
        public String datasourceHealthCheck() {
            log.info("Configuración de datasource inicializada para verificación de salud");
            return "dataSourceHealthy";
        }
    }
}
```
