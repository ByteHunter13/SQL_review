-- Selección de registros que cumplan una condición
SELECT * 
FROM employee_salary 
WHERE first_name = 'Leslie';

SELECT * 
FROM employee_salary 
WHERE salary > 50000;

-- Las comparaciones de toda la vida
SELECT * 
FROM employee_salary 
WHERE salary >= 50000;

SELECT * 
FROM employee_demographics 
WHERE gender != 'Female';

SELECT * 
FROM employee_demographics 
WHERE birth_date > '1985-01-01';

-- Operadores lógicos AND OR NOT
SELECT * 
FROM employee_demographics 
WHERE birth_date > '1985-01-01' 
AND gender = 'Male';

SELECT * 
FROM employee_demographics 
WHERE birth_date > '1985-01-01' 
OR NOT gender = 'Male'; -- Devuélve solo los hombres que nacieron después de '1985-01-01'

SELECT *
FROM employee_demographics
WHERE (
	first_name = 'Leslie' 
	AND age = 44) -- Podemos agrupar condiciones
OR age > 55;

-- LIKE
-- % & _
SELECT *
FROM employee_demographics
WHERE first_name = 'Jerry';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%'; -- También devuelve Jerry, siempre que el nombre comience con Jer

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'A%'; -- April, Ann, Andy

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'A__'; -- Ann, que cumpla el tamaño

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'A__%'; -- April, Ann, Andy

-- ILIKE - Para que no distinga mayúsculas y minúsculas
SELECT *
FROM employee_demographics
WHERE last_name ILIKE 'b%'; -- Brendanawicz

-- NOT LIKE
SELECT *
FROM employee_demographics
WHERE first_name NOT ILIKE 'a%';


-- Si se necesitara buscar un '%' o un '_', se puede usar: LIKE %50%% ESCAPE '\'
