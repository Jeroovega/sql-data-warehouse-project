/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Objetivo:
    Crear las tablas de la capa 'silver', eliminando previamente las tablas
    existentes para redefinir su estructura.

    La capa Silver contiene los datos provenientes de Bronze con una estructura
    limpia y estandarizada.

    Las transformaciones, limpieza y relaciones entre tablas se realizan
    posteriormente durante el proceso Clean & Load.

Tablas:
    - silver.canales
    - silver.canales_estadisticas
    - silver.programas
    - silver.videos
    - silver.videos_detalles

Uso:
    Ejecutar este script antes del proceso de carga de Silver.
===============================================================================
*/


-- ============================================================================
-- Tabla: silver.canales
-- ============================================================================

DROP TABLE IF EXISTS silver.canales;

CREATE TABLE silver.canales (
    id_canal      		  BIGINT,
    nombre_canal          TEXT,
    url_yt_canal    	  TEXT,
    color_canal           TEXT,
    fecha_creacion        TIMESTAMP WITH TIME ZONE
);


-- ============================================================================
-- Tabla: silver.canales_estadisticas
-- ============================================================================

DROP TABLE IF EXISTS silver.canales_estadisticas;

CREATE TABLE silver.canales_estadisticas (
    id_canal            	 BIGINT,
    subscriptores       	 BIGINT,
    visitas_totales 		 BIGINT,
    videos_totales   	     BIGINT,
    fecha           	     DATE,
    fecha_compilacion        TIMESTAMP WITH TIME ZONE
);


-- ============================================================================
-- Tabla: silver.programas
-- ============================================================================

DROP TABLE IF EXISTS silver.programas;

CREATE TABLE silver.programas (
    id_programa    	 BIGINT,
    nombre_programa  TEXT
);


-- ============================================================================
-- Tabla: silver.videos
-- ============================================================================

DROP TABLE IF EXISTS silver.videos;

CREATE TABLE silver.videos (
    id_video       		 BIGINT,
    visitas_video        BIGINT,
    likes_video          BIGINT,
    comentarios_video    BIGINT
);


-- ============================================================================
-- Tabla: silver.videos_detalles
-- ============================================================================

DROP TABLE IF EXISTS silver.videos_detalles;

CREATE TABLE silver.videos_detalles (
    id_video             BIGINT,
    id_canal             BIGINT,
    id_programa          BIGINT,
    titulo               TEXT,
    duracion             BIGINT,
    url_video	         TEXT,
    fecha_publicacion    DATE,
    url_miniatura        TEXT,
    fecha_creacion           TIMESTAMP WITH TIME ZONE,
    fecha_procesado          TIMESTAMP WITH TIME ZONE
);
