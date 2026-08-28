/* 
===============================================================================
Stored Procedure: Cargar Capa Silver (Bronze -> Silver)
===============================================================================
Objetivo:
	Se ejecuta el proceso ETL para crear las tablas del schema 'silver' desde
	el schema 'bronze'.
	Acciones realizadas:
		- Truncar tablas Silver.
		- Insertar datos transformados y limpiados en tablas Silver desde Bronze.

Parametros:
	Ninguno. No acepta parametros o devuelve ningun valor.

Uso:
	EXEC silver.load_silver
*/

CREATE OR REPLACE PROCEDURE silver.load_silver()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    batch_start_time TIMESTAMP;
    batch_end_time TIMESTAMP;
BEGIN
	batch_start_time := clock_timestamp();

	RAISE NOTICE '================================================';
    RAISE NOTICE 'Loading Silver Layer';
    RAISE NOTICE '================================================';

    --------------------------------------------------------------------------
    -- Cargando silver.programas
    --------------------------------------------------------------------------

    start_time := clock_timestamp();

    RAISE NOTICE '>> Truncando tabla: silver.programas';
    TRUNCATE TABLE silver.programas;

    RAISE NOTICE '>> Insertando datos en: silver.programas';

    INSERT INTO silver.programas (
        id_programa,
        nombre_programa
    )
    SELECT
        ROW_NUMBER() OVER (ORDER BY program) AS id_programa,
        TRIM(program) AS nombre_programa
    FROM (
        SELECT DISTINCT
            TRIM(program) AS program
        FROM bronze.apiyt_videos
        WHERE program IS NOT NULL
    ) p;

    end_time := clock_timestamp();

    RAISE NOTICE '>> Duración: % segundos',
        EXTRACT(EPOCH FROM (end_time - start_time));
		
	--------------------------------------------------------------------------
    -- Cargando silver.canales
    --------------------------------------------------------------------------

    start_time := clock_timestamp();

    RAISE NOTICE '>> Truncando tabla: silver.canales';
    TRUNCATE TABLE silver.canales;

    RAISE NOTICE '>> Insertando datos en: silver.canales';

    INSERT INTO silver.canales (
        id_canal,
        nombre_canal,
        url_yt_canal,
        color_canal,
        fecha_creacion
    )
    SELECT
        id AS id_canal,
        name AS nombre_canal,
        youtube_id AS url_yt_canal,
        color AS color_canal,
        created_at AS fecha_creacion
    FROM bronze.apiyt_canales;

    end_time := clock_timestamp();

    RAISE NOTICE '>> Duración: % segundos',
        EXTRACT(EPOCH FROM (end_time - start_time));


    --------------------------------------------------------------------------
    -- Cargando silver.canales_estadisticas
    --------------------------------------------------------------------------

    start_time := clock_timestamp();

    RAISE NOTICE '>> Truncando tabla: silver.canales_estadisticas';
    TRUNCATE TABLE silver.canales_estadisticas;

    RAISE NOTICE '>> Insertando datos en: silver.canales_estadisticas';

    INSERT INTO silver.canales_estadisticas (
        id_canal,
        subscriptores,
        visitas_totales,
        videos_totales,
        fecha,
        fecha_compilacion
    )
    SELECT
        channel_id AS id_canal,
        subs AS subscriptores,
        total_views AS visitas_totales,
        total_videos AS videos_totales,
        date AS fecha,
        collected_at AS fecha_compilacion
    FROM bronze.apiyt_canales_estadisticas;

    end_time := clock_timestamp();

    RAISE NOTICE '>> Duración: % segundos',
        EXTRACT(EPOCH FROM (end_time - start_time));


    --------------------------------------------------------------------------
    -- Cargando silver.videos_detalles
    --------------------------------------------------------------------------

    start_time := clock_timestamp();

    RAISE NOTICE '>> Truncando tabla: silver.videos_detalles';
    TRUNCATE TABLE silver.videos_detalles;

    RAISE NOTICE '>> Insertando datos en: silver.videos_detalles';

    INSERT INTO silver.videos_detalles (
        id_video,
        id_canal,
        id_programa,
        titulo,
        duracion,
        url_video,
        fecha_publicacion,
        url_miniatura,
        fecha_creacion,
        fecha_procesado
    )
    SELECT
        v.id AS id_video,
        v.channel_id AS id_canal,
        p.id_programa,
        TRIM(v.title) AS titulo,
        v.duration AS duracion,
        v.youtube_id AS url_video,
        v.upload_date AS fecha_publicacion,
        v.thumbnail_url AS url_miniatura,
        v.created_at AS fecha_creacion,
        v.processed_at AS fecha_procesado
    FROM bronze.apiyt_videos v
    JOIN silver.programas p
        ON p.nombre_programa = TRIM(v.program);

    end_time := clock_timestamp();

    RAISE NOTICE '>> Duración: % segundos',
        EXTRACT(EPOCH FROM (end_time - start_time));


    --------------------------------------------------------------------------
    -- Cargando silver.videos
    --------------------------------------------------------------------------

    start_time := clock_timestamp();

    RAISE NOTICE '>> Truncando tabla: silver.videos';
    TRUNCATE TABLE silver.videos;

    RAISE NOTICE '>> Insertando datos en: silver.videos';

    INSERT INTO silver.videos (
        id_video,
        visitas_video,
        likes_video,
        comentarios_video
    )
    SELECT
        id AS id_video,
        views AS visitas_video,
        likes AS likes_video,
        comments_count AS comentarios_video
    FROM bronze.apiyt_videos;

    end_time := clock_timestamp();

    RAISE NOTICE '>> Duración: % segundos',
        EXTRACT(EPOCH FROM (end_time - start_time));


    --------------------------------------------------------------------------
    -- Finalización
    --------------------------------------------------------------------------

    batch_end_time := clock_timestamp();

    RAISE NOTICE '================================================';
    RAISE NOTICE 'Silver Layer cargada correctamente';
    RAISE NOTICE 'Duración total: % segundos',
        EXTRACT(EPOCH FROM (batch_end_time - batch_start_time));
    RAISE NOTICE '================================================';

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Error durante la carga de Silver: %', SQLERRM;
END;
$$;
