# Data Warehouse para datos de LuzuTV y Olga. 🚀
Construcción de un Data Warehouse moderno con PostgreSQL, incluyendo procesos ETL, modelado de datos y analíticas.
Bienvenidx al repositorio del proyecto de Data Warehouse en el ecosistema de canales de streaming.

Este proyecto presenta una solución de almacenamiento y análisis de datos, que abarca desde la creación del almacén de datos hasta la generación de información o estadísticas útiles. Diseñado como un proyecto de portafolio, destaca las **mejores prácticas** de la industria en **ingeniería** de **datos** y análisis.

Organización de datos a **gran escala** en el ecosistema de canales de streaming. Se busca aplicar las medidas, estrategias, arquitecturas y modelados de empresas con alto desarrollo en el área de datos.

## 📌 Descripción general del proyecto.

Este proyecto incluye:

1. `Arquitectura de Datos:` Diseñando un Data Warehouse Moderno utilizando una Medallion Architecture compuesta por capas: Bronze, Silver y Gold.
2. `ETL Pipelines:` Extracción, trasnformación y carga de datos desde fuentes del sistema hacia el warehouse.
3. `Modelado de Datos:` Desarrollo de tablas facts y dimensiones optimizadas para consultas analíticas por parte de los analistas.
4. `Analitica y Reporte:` Creación de SQL basado en reportes y dashboards para la toma de decisiones.

### | Preguntas Principales

Un Data Warehouse es importantísimo, por el simple motivo de tener tus datos constantemente actualizandose. Imagináte diferentes equipos trabajando a la vez en por ejemplo.

`En un Excel | En un PowerPoint | En un analisis`

Es importante que esas personas tengan la misma versión de los datos, ya que sino siempre habría discrepancias entre los reportes. Esto en el área de streaming es importante ya que las estadísticas en plataformas como Youtube se actualizan constantemente. Y un plus, todo este proceso de actualización de los datos constantemente se encuentra automatizado, por lo que no hay pasos manuales lo que reduce errores y lo acelera.

- **Qué es un Data Warehouse?**
    
    Un **Data Warehouse (DWH)** es un sistema centralizado que almacena datos **estructurados, procesados y preparados para el análisis**. Integra información proveniente de distintas fuentes para facilitar consultas, métricas, reportes y toma de decisiones.
    

- **Qué beneficios brinda?**
    
    Permite centralizar los datos de distintas áreas, mantener información histórica y realizar análisis de forma **rápida, consistente y escalable**. También facilita la creación de dashboards y evita depender directamente de las bases de datos operacionales.
    

- **Quiénes utilizarían el Data Warehouse?**
    
    Principalmente **Data Analysts, BI Analysts, Data Engineers y equipos de negocio**. Por ejemplo, un analista podría utilizarlo para estudiar audiencia, rendimiento de programas, empleados, ingresos o evolución de métricas.
    

- **Qué datos almacenaría LuzuTV-OLGA?**
    
    Datos provenientes de **YouTube, redes sociales, PostgreSQL, sistemas de RRHH, ventas, publicidad y otras fuentes**. Estos datos serían transformados y organizados para su posterior análisis.
    

## **🚀 Misión** del Proyecto

### 1. Construcción de un Data Warehouse Ingenieria de Datos | Data Engineering.

> Objetivo
> 

Desarrollar un Data Warehouse moderno utilizando PostgreSQL para centralizar las métricas digitales de los canales de YouTube de LuzuTV y OLGA, facilitando el análisis de audiencia, rendimiento de contenidos y evolución de las métricas para la toma de decisiones.

> Especificaciones
> 
- **Fuentes de Datos:** Migración de antigua base de datos y posteriormente actualizados a través de la actualidad de los canales de YouTube mediante la **YouTube Data API.** Se almacenan inicialmente en archivos CSV.
- **Calidad de Datos:** Identificar, limpiar y resolver problemas de calidad antes de utilizar los datos para el análisis.
- **Integración:** Consolidar la información de ambos canales en un único modelo de datos, facilitando las consultas y comparaciones analíticas.
- **Transformación:** Aplicar procesos de limpieza, estandarización y transformación para convertir los datos provenientes de la API en información estructurada y confiable.
- **Modelado:** Diseñar un modelo dimensional utilizando **tablas de hechos y dimensiones**, orientado a consultas analíticas.
- **Documentación:** Proporcionar documentación clara sobre la arquitectura, transformación y modelado de los datos, de manera que pueda ser comprendida tanto por perfiles técnicos como por usuarios de negocio.

---

### 2. BI: Analiticas y Reportes Analisis de datos | Data Analysis.

> Objetivo
> 

Desarrollar análisis basados en **SQL** para obtener información detallada sobre el comportamiento y rendimiento de los canales y sus contenidos.

> Los análisis estarán orientados a:
> 
- **Comportamiento de la audiencia:** Visualizaciones, likes, comentarios y evolución de la interacción.
- **Rendimiento de contenidos:** Análisis del desempeño de videos, programas y canales.
- **Tendencias:** Evolución de las métricas a través del tiempo, identificando patrones y cambios relevantes.
- **Comparación entre canales:** Análisis comparativo entre LuzuTV y OLGA.
- **Rendimiento temporal:** Análisis de métricas según fecha, día de la semana, mes, duración del contenido, etc.

Estos análisis permitirán transformar las métricas obtenidas de YouTube en **información útil para comprender el comportamiento de la audiencia y apoyar la toma de decisiones**.

---
## ☕ Contacto

Si te interesó el proyecto, tenés alguna consulta o sugerencia, o representás a alguna de las organizaciones mencionadas y querés solicitar modificaciones o la eliminación de alguna referencia, no dudes en comunicarte conmigo.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jeronimo-vega/)

📩 `jerovegadev@gmail.com`

---
