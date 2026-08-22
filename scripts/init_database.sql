/* 
===================================================================
Creación Base de Datos y Schemas
===================================================================
Objetivo del Script:
  Este script crea una nueva base de datos llamada "DataWarehouse" despues de chequear si ya existe.
  Si la base de datos existe, se elimina y se recrea. Adicionalmente el script configura tres schemas
  en la base de datos: 'bronze', 'silver', 'gold'.

Advertencia:
  Correr el script eliminará la base de datos "DataWarehouse" ENTERA si ya existe.
  Todos los datos serán permanentemente borrados. Proceda con precaución y asegurese
  de preveer backups antes de correr el script.
*/

-- En caso de que exista borrar la base de datos y recrearla.
DROP DATABASE IF EXISTS "DataWarehouse" WITH (FORCE);
-- Crear Base de Datos 'DataWarehouse'
CREATE DATABASE DataWarehouse;

-- Creación de Schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
