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