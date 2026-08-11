SET datestyle = 'ISO, MDY'; -- Se cambia el tipo de fecha, en el csv viene en formato americano
COPY layoffs (company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) -- se seleccionan las columnas donde irán los datos
FROM 'C:\layoffs.csv' -- Cambié de lugar el archivo, probablemente con los demás arreglos debería de funcionar sin cambiarlo, estaba en mi drive
DELIMITER ',' -- limitador del csv
CSV HEADER -- que tome los nombres del header
NULL 'NULL'; -- en el csv literalmente los valores son la cadena NULL, hay que avisar a postgres


CREATE TABLE layoffs (
	company VARCHAR(50), 
	location VARCHAR(50), 
	industry VARCHAR(50), 
	total_laid_off INT, 
	percentage_laid_off NUMERIC(12, 2) DEFAULT NULL,
	date DATE, 
	stage VARCHAR(50), 
	country VARCHAR(50), 
	funds_raised_millions NUMERIC(12, 2) DEFAULT NULL
);

SELECT * FROM layoffs;