-- Funciones de agregación
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- Funciones de agregación
-- AVG, MAX, MIN, COUNT
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender; -- Agrupa los datos dividiéndolos solo en Female y Male

SELECT occupation, AVG(salary)
FROM employee_salary
GROUP BY occupation;

-- HAVING
SELECT occupation, AVG(salary)
FROM employee_salary
GROUP BY occupation
HAVING AVG(salary) > 50000; -- Condición dentro de la agrupación

SELECT STRING_AGG(first_name, ', ')
FROM employee_demographics
WHERE first_name ILIKE 'a%'; -- Concatena los nombres separandolos por coma y espacio

-- ORDER BY
SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

-- Otras funciones de agregación
-- ARRAY_AGG: En vez de concatenar, los mete en un array
-- STDDEV: Desviación estándar
-- VARIANCE: Varianza
-- BOOL_AND: TRUE si todos son TRUE
-- BOOL_OR: TRUE si al menos uno es TRUE