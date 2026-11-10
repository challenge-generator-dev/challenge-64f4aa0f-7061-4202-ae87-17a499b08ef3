# Versionado de Infraestructura con Terraform para el Servicio de Órdenes

El equipo de desarrollo de un servicio de gestión de órdenes en una plataforma de comercio electrónico necesita versionar su infraestructura utilizando Terraform. El objetivo es asegurar que la infraestructura AWS requerida por el servicio de órdenes sea desplegada de manera consistente y versionada. Los actores involucrados son el Equipo de Desarrollo, el Servicio de Órdenes y la Infraestructura AWS. El problema a resolver es asegurar que la infraestructura se despliegue correctamente y se mantenga versionada para facilitar la gestión y el despliegue en diferentes entornos.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el servicio de ordenes |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: JDK 17+, Maven 3.9+, IDE con soporte Java.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `mvn compile` en la raíz. Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración Inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para la gestión de la infraestructura AWS.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Configurar el entorno de Terraform para interactuar con la cuenta de AWS.
- Definir las variables necesarias para el despliegue de la infraestructura.

**Entregable:** Configuración de Terraform lista para el despliegue de la infraestructura.

<details>
<summary>Pistas de conocimiento</summary>

- Uso de variables en Terraform para parametrizar el despliegue.
- Configuración de proveedores en Terraform.

</details>

### Fase 2: Despliegue de la Infraestructura AWS

**Objetivo:** Desplegar la infraestructura necesaria para el servicio de órdenes utilizando Terraform.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Crear los recursos de AWS necesarios para el servicio de órdenes.
- Asegurar que los recursos se despliegan de manera idempotente.

**Entregable:** Infraestructura AWS desplegada y versionada utilizando Terraform.

<details>
<summary>Pistas de conocimiento</summary>

- Creación de recursos en Terraform.
- Idempotencia en despliegues de infraestructura.

</details>

### Fase 3: Versionado y Gestión de la Infraestructura

**Objetivo:** Versionar y gestionar la infraestructura desplegada utilizando Terraform.

**Tiempo estimado:** 3 horas

**Instrucciones:**

- Versionar el código de Terraform en un repositorio de control de versiones.
- Implementar un proceso para actualizar la infraestructura de manera controlada.

**Entregable:** Proceso documentado para versionar y actualizar la infraestructura utilizando Terraform.

<details>
<summary>Pistas de conocimiento</summary>

- Uso de repositorios de control de versiones para Terraform.
- Estrategias para actualizar infraestructura versionada.
- Java: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y cómo se utiliza para gestionar infraestructura?
- **paraQueSirve**: ¿Para qué sirve versionar la infraestructura con Terraform?
- **comoSeUsa**: ¿Cómo se configura y despliega infraestructura con Terraform?
- **erroresComunes**: ¿Cuáles son los errores comunes al desplegar infraestructura con Terraform y cómo se evitan?
- **queDecisionesImplica**: ¿Qué decisiones implica versionar y gestionar la infraestructura con Terraform?

## Criterios de Evaluacion

- Configuración inicial de Terraform para AWS.
- Despliegue idempotente de infraestructura AWS.
- Versionado y gestión de la infraestructura con Terraform.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd api && mvn clean compile)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
