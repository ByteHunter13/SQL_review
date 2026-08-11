SELECT * FROM layoffs;

-- 1. Quitar duplicados
-- 2. Estandarizar los datos
-- 3. Valores NULL
-- 4. Quitar cualquier columna no necesaria

-- Duplicamos la tabla para modificar y tener los datos originales
CREATE TABLE layoffs_staging (LIKE layoffs);

INSERT INTO layoffs_staging
SELECT *
FROM layoffs;

-- 1. Quitar duplicados

SELECT *, 
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
	) AS row_num
FROM layoffs_staging;

-- Con una función de ventana y un CTE obtenemos los valores duplicados
WITH duplicate_cte AS (
	SELECT *, 
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
	) AS row_num
	FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num>1;


-- Creamos una nueva tabla para pasar los duplicados porque no se pueden borrar directo en la consulta
CREATE TABLE layoffs_staging_2 (
	company VARCHAR(50), 
	location VARCHAR(50), 
	industry VARCHAR(50), 
	total_laid_off INT, 
	percentage_laid_off NUMERIC(12, 2) DEFAULT NULL,
	date DATE, 
	stage VARCHAR(50), 
	country VARCHAR(50), 
	funds_raised_millions NUMERIC(12, 2) DEFAULT NULL,
	row_num INT
);

SELECT * FROM layoffs_staging_2;

INSERT INTO layoffs_staging_2
SELECT *, 
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
	) AS row_num
FROM layoffs_staging;

-- Obtenemos solo los que están suplicados
SELECT * FROM layoffs_staging_2 WHERE row_num>1;

-- Los borramos
DELETE FROM layoffs_staging_2 WHERE row_num>1;

SELECT * FROM layoffs_staging_2;

-- 2. Estandarizar los datos
SELECT company, TRIM(company)
FROM layoffs_staging_2;

-- Quitamos los espacios al inicio y al final
UPDATE layoffs_staging_2
SET company = TRIM(company);

-- Verificamos contenido similar
SELECT *
FROM layoffs_staging_2
WHERE industry ILIKE 'crypto%';

-- Actualizamos
UPDATE layoffs_staging_2
SET industry = 'Crypto'
WHERE industry ILIKE 'crypto%'

-- Ubicamos paises con un punto al final
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging_2
ORDER BY 1;

-- Y los actualizamos
UPDATE layoffs_staging_2
SET country = TRIM(TRAILING '.' FROM country)

SELECT *
FROM layoffs_staging_2;
WHERE country ILIKE 'United States%';

-- 3. Valores NULL
SELECT *
FROM layoffs_staging_2
WHERE total_laid_off IS NULL;

UPDATE layoffs_staging_2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging_2
WHERE company = 'Airbnb';

-- Buscamos registros NULL o vacíos que se puedan llenar con otro registro similar
SELECT t1.industry, t2.industry
FROM layoffs_staging_2 t1
JOIN layoffs_staging_2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- Actualizamos con los valores que no son nulos
UPDATE layoffs_staging_2 AS t1
SET industry = t2.industry
FROM layoffs_staging_2 AS t2
WHERE t1.company = t2.company
	AND t1.industry IS NULL
	AND t2.industry IS NOT NULL;


SELECT *
FROM layoffs_staging_2
WHERE company ILIKE 'Ball%';

-- 4. Quitar cualquier columna o dato no necesario
SELECT *
FROM layoffs_staging_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging_2;

ALTER TABLE layoffs_staging_2
DROP COLUMN row_num;
