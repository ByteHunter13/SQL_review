-- String Functions
SELECT LENGTH('skyfall');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics;

SELECT first_name, UPPER(first_name)
FROM employee_demographics;

SELECT LTRIM('    sky    ');
SELECT RTRIM('      sky    ');

SELECT 
	first_name,
	LEFT(first_name, 4),
	RIGHT(first_name, 4),
	SUBSTRING(first_name, 3, 2),
	birth_date,
	SUBSTRING(TEXT(birth_date), 6, 2)
FROM employee_demographics;

SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics;

SELECT POSITION('x' IN 'Alexander');

SELECT first_name, POSITION('An' IN first_name)
FROM employee_demographics;

SELECT first_name, last_name,
CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;