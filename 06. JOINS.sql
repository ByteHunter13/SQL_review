-- Joins
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- INNER
SELECT demographics.employee_id, age, occupation
FROM employee_demographics AS demographics
INNER JOIN employee_salary AS salary
ON demographics.employee_id = salary.employee_id; -- 2 no aparece porque no está en ambas tablas

-- OUTER
SELECT *
FROM employee_demographics AS demographics
LEFT OUTER JOIN employee_salary AS salary
ON demographics.employee_id = salary.employee_id;

SELECT *
FROM employee_demographics AS demographics
RIGHT OUTER JOIN employee_salary AS salary
ON demographics.employee_id = salary.employee_id; -- Aparecen null en el employee_id = 2

-- SELF
SELECT *
FROM employee_salary AS salary_1
JOIN employee_salary AS salary_2
ON salary_1.employee_id+1 = salary_2.employee_id;

-- Ejemplo para asignación de intercambio de regalos
SELECT salary_1.employee_id AS employee_santa, 
salary_1.first_name AS first_name_santa,
salary_1.last_name AS last_name_santa,
salary_2.employee_id AS employee_santa, 
salary_2.first_name AS first_name,
salary_2.last_name AS last_name
FROM employee_salary AS salary_1
JOIN employee_salary AS salary_2
ON salary_1.employee_id+1 = salary_2.employee_id;

-- Varias tablas
SELECT *
FROM employee_demographics AS demographics
INNER JOIN employee_salary AS salary
ON demographics.employee_id = salary.employee_id
INNER JOIN parks_departments AS pd
ON salary.dept_id = pd.department_id;
