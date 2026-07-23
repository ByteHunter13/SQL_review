-- Having vs Where
SELECT gender, AVG(age)
FROM employee_demographics
WHERE AVG(age) > 40
GROUP BY gender; -- No funcionará

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40; -- Modo correcto

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation ILIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000; -- Usando ambos modos