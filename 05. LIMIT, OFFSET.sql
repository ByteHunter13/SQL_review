-- Limit & Aliasing
SELECT * 
FROM employee_demographics
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3 OFFSET 1; -- Se salta el primer registro

-- Útil para paginaciones
