-- STORED PROCEDURES OR FUNCTIONS (PostgreSQL)
SELECT *
FROM employee_salary
WHERE salary>=50000;

-- FUNCTION
CREATE OR REPLACE FUNCTION large_salaries_f()
RETURNS TABLE(
    -- Reemplaza estos nombres y tipos con las columnas reales de tu tabla employee_salary
    employee_id INT, 
    first_name VARCHAR, 
    salary INT
) 
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT e.employee_id, e.first_name, e.salary
    FROM employee_salary e
    WHERE e.salary >= 50000;
END;
$$;

SELECT * FROM large_salaries_f();

-- PROCEDURE
CREATE PROCEDURE large_salaries()
LANGUAGE plpgsql
AS $$
BEGIN
	PERFORM * FROM employee_salary WHERE salary>=50000;
END;
$$;

CALL large_salaries();