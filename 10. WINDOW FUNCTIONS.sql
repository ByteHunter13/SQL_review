-- WINDOW FUNCTIONS
SELECT dem.first_name, dem.last_name, gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id
GROUP BY dem.first_name, dem.last_name, gender;

-- Pone el promedio sin agrupar
SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER (PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- Con función agregada SUM
SELECT dem.first_name, dem.last_name, gender, salary, SUM(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;

-- Ranqueo de salarios por género
SELECT dem.employee_id, dem.first_name, dem.last_name, dem.gender, sal.salary, 
    ROW_NUMBER() OVER(PARTITION BY gender ORDER BY dem.gender DESC) AS row_num,
	RANK() OVER(PARTITION BY dem.gender ORDER BY sal.salary DESC) AS rank_num,
	DENSE_RANK() OVER (PARTITION BY dem.gender ORDER BY sal.salary DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id