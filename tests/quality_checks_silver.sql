# Silver Layer — Quality Checks

# /*

# Quality Checks — Silver Layer

Objetivo:
Realizar controles de calidad sobre las tablas de la capa Silver para
verificar integridad, consistencia, estandarización y relaciones entre
los datos provenientes de Bronze.

Los controles incluyen:
- Valores NULL en identificadores.
- Duplicados en identificadores.
- Espacios innecesarios en campos de texto.
- Valores negativos o inválidos.
- Consistencia de relaciones entre tablas.
- Validación de fechas.
- Estandarización de categorías.

Uso:
Ejecutar después de silver.load_silver().
Los queries están diseñados principalmente para no devolver resultados
cuando los datos cumplen las reglas de calidad.
===============================================

*/

-- ============================================================================
-- Chequeando 'silver.programas'
-- ============================================================================

-- Chequear NULLs o duplicados en la PK
SELECT
id_programa,
COUNT(*)
FROM silver.programas
GROUP BY id_programa
HAVING COUNT(*) > 1
OR id_programa IS NULL;

-- Chequear nombres NULL o vacíos
SELECT *
FROM silver.programas
WHERE nombre_programa IS NULL
OR TRIM(nombre_programa) = '';

-- Chequear espacios innecesarios
SELECT *
FROM silver.programas
WHERE nombre_programa != TRIM(nombre_programa);

-- Verificar programas existentes
SELECT DISTINCT
nombre_programa
FROM silver.programas
ORDER BY nombre_programa;

-- ============================================================================
-- Chequeando 'silver.canales'
-- ============================================================================

-- Chequear NULLs o duplicados en la PK
SELECT
id_canal,
COUNT(*)
FROM silver.canales
GROUP BY id_canal
HAVING COUNT(*) > 1
OR id_canal IS NULL;

-- Chequear espacios innecesarios
SELECT *
FROM silver.canales
WHERE nombre_canal != TRIM(nombre_canal);

-- Chequear nombre del canal NULL o vacío
SELECT *
FROM silver.canales
WHERE nombre_canal IS NULL
OR TRIM(nombre_canal) = '';

-- Verificar canales existentes
SELECT DISTINCT
nombre_canal
FROM silver.canales
ORDER BY nombre_canal;

-- ============================================================================
-- Chequeando 'silver.canales_estadisticas'
-- ============================================================================

-- Chequear NULLs en el identificador del canal
SELECT *
FROM silver.canales_estadisticas
WHERE id_canal IS NULL;

-- Chequear suscriptores inválidos
SELECT *
FROM silver.canales_estadisticas
WHERE subscriptores IS NULL
OR subscriptores < 0;

-- Chequear visitas totales inválidas
SELECT *
FROM silver.canales_estadisticas
WHERE visitas_totales IS NULL
OR visitas_totales < 0;

-- Chequear cantidad de videos inválida
SELECT *
FROM silver.canales_estadisticas
WHERE videos_totales IS NULL
OR videos_totales < 0;

-- Chequear fechas inválidas
SELECT *
FROM silver.canales_estadisticas
WHERE fecha IS NULL;

-- Verificar que cada estadística corresponda a un canal existente
SELECT ce.*
FROM silver.canales_estadisticas ce
LEFT JOIN silver.canales c
ON ce.id_canal = c.id_canal
WHERE c.id_canal IS NULL;

-- ============================================================================
-- Chequeando 'silver.videos_detalles'
-- ============================================================================

-- Chequear NULLs o duplicados en la PK
SELECT
id_video,
COUNT(*)
FROM silver.videos_detalles
GROUP BY id_video
HAVING COUNT(*) > 1
OR id_video IS NULL;

-- Chequear espacios innecesarios en títulos
SELECT *
FROM silver.videos_detalles
WHERE titulo != TRIM(titulo);

-- Chequear títulos NULL o vacíos
SELECT *
FROM silver.videos_detalles
WHERE titulo IS NULL
OR TRIM(titulo) = '';

-- Chequear duración inválida
SELECT *
FROM silver.videos_detalles
WHERE duracion IS NULL
OR duracion < 0;

-- Chequear fecha de publicación
SELECT *
FROM silver.videos_detalles
WHERE fecha_publicacion IS NULL;

-- Verificar que cada video tenga un canal existente
SELECT vd.*
FROM silver.videos_detalles vd
LEFT JOIN silver.canales c
ON vd.id_canal = c.id_canal
WHERE c.id_canal IS NULL;

-- Verificar que cada video tenga un programa existente
SELECT vd.*
FROM silver.videos_detalles vd
LEFT JOIN silver.programas p
ON vd.id_programa = p.id_programa
WHERE p.id_programa IS NULL;

-- Verificar programas existentes
SELECT DISTINCT
p.nombre_programa
FROM silver.programas p
ORDER BY p.nombre_programa;

-- ============================================================================
-- Chequeando 'silver.videos'
-- ============================================================================

-- Chequear NULLs o duplicados en la PK
SELECT
id_video,
COUNT(*)
FROM silver.videos
GROUP BY id_video
HAVING COUNT(*) > 1
OR id_video IS NULL;

-- Chequear visitas inválidas
SELECT *
FROM silver.videos
WHERE visitas_video IS NULL
OR visitas_video < 0;

-- Chequear likes inválidos
SELECT *
FROM silver.videos
WHERE likes_video IS NULL
OR likes_video < 0;

-- Chequear comentarios inválidos
SELECT *
FROM silver.videos
WHERE comentarios_video IS NULL
OR comentarios_video < 0;

-- Verificar que cada métrica corresponda a un video existente
SELECT v.*
FROM silver.videos v
LEFT JOIN silver.videos_detalles vd
ON v.id_video = vd.id_video
WHERE vd.id_video IS NULL;

-- ============================================================================
-- Chequeos de consistencia entre tablas
-- ============================================================================

-- Verificar que videos y videos_detalles tengan la misma cantidad de videos
SELECT
(SELECT COUNT(*) FROM silver.videos) AS total_videos,
(SELECT COUNT(*) FROM silver.videos_detalles) AS total_videos_detalles;

-- Verificar videos que existen en detalles pero no en métricas
SELECT vd.id_video
FROM silver.videos_detalles vd
LEFT JOIN silver.videos v
ON vd.id_video = v.id_video
WHERE v.id_video IS NULL;

-- Verificar videos que existen en métricas pero no en detalles
SELECT v.id_video
FROM silver.videos v
LEFT JOIN silver.videos_detalles vd
ON v.id_video = vd.id_video
WHERE vd.id_video IS NULL;
