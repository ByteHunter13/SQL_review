-- Exploratory Data Analysis
SELECT *
FROM layoffs_staging_2;


-- Máxima gente despedida
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging_2;

-- Compañías que despidieron a todos
SELECT *
FROM layoffs_staging_2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Suma total de despedidos
SELECT company, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company
ORDER BY 2 DESC;

-- Fechas que comenzaron los despidos
-- Probablemente los despidos comenzaron con el COVID
SELECT MIN(date), MAX(date)
FROM layoffs_staging_2;


-- Los sectores de consumo y minoristas fueron los más afectados
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY industry
ORDER BY 2 DESC;

-- El pais más afectado fue Estados Unidos
SELECT country, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY country
ORDER BY 2 DESC;

-- Los despidos comenzaron en marzo del 2020
SELECT date, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY date
ORDER BY 1;

-- En 2023 fue la mayor cantidad de despidos
SELECT DATE_PART('year', date), SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY DATE_PART('year', date)
ORDER BY 1 DESC;

-- Periodo financiero
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY stage
ORDER BY 1 DESC;

-- Porcentaje de despidos por empresa
SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging_2
GROUP BY company
ORDER BY 2 DESC;

-- Los meses en los que hubo más despidos
SELECT SUBSTRING(TEXT(date) FROM 1 FOR 7) AS year_month,
	SUM(total_laid_off)
FROM layoffs_staging_2
WHERE SUBSTRING(TEXT(date) FROM 1 FOR 7) IS NOT NULL
GROUP BY year_month
ORDER BY 1;


-- Acumulable de despidos a lo largo del tiempo
-- noviembre de 2022 a los 3 primeros meses del 2023 fue casi el 30% del total
WITH Rolling_Total AS
(
	SELECT SUBSTRING(TEXT(date) FROM 1 FOR 7) AS year_month,
		SUM(total_laid_off) AS total_off
	FROM layoffs_staging_2
	WHERE SUBSTRING(TEXT(date) FROM 1 FOR 7) IS NOT NULL
	GROUP BY year_month
	ORDER BY 1 ASC
)
SELECT year_month, total_off,
SUM(total_off) OVER(ORDER BY year_month) AS rolling_total
FROM Rolling_Total;


-- Suma total de despidos por año y por empresa
SELECT company, DATE_PART('year', date) AS year, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company, year
ORDER BY 3 DESC;


-- Top 5 de compañías que despidieron a más empleados
WITH Company_Year(company, years, total_laid_offs) AS
(
	SELECT company, DATE_PART('year', date) AS year, SUM(total_laid_off)
	FROM layoffs_staging_2
	GROUP BY company, year
), Company_Year_Rank AS
(
	SELECT *, 
	DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_offs DESC NULLS LAST) AS Ranking
	FROM Company_Year
	WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking<=5;
