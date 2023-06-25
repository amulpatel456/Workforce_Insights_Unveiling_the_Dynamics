SELECT * FROM hr;

-- Query to change the column name "ï»¿id" to "emp_id" and modify its datatype to VARCHAR(20) allowing NULL values
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

-- Query to disable safe updates, allowing updates without a WHERE clause
SET sql_safe_updates = 0;


-- Query to update the "birthdate" column by converting date values from different formats to 'YYYY-MM-DD' format
UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Query to modify the datatype of the "birthdate" column to DATE
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- Query to update the "hire_date" column by converting date values from different formats to 'YYYY-MM-DD' format

UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

-- Query to modify the datatype of the "hire_date" column to DATE
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- Query to update the "termdate" column by converting datetime values to date values
UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

-- Set invalid 'termdate' values to NUL
UPDATE hr
SET termdate = IFNULL(termdate, '0000-00-00')
WHERE termdate IS NULL OR termdate = '';

UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate = '';


-- Query to modify the datatype of the "termdate" column to DATE
SELECT @@sql_mode;
SET sql_mode = '';
ALTER TABLE hr 
MODIFY COLUMN termdate DATE DEFAULT '0000-00-00';


-- Query to add a new column named "age" of datatype INT to the "hr" table
ALTER TABLE hr ADD COLUMN age INT;

-- Query to calculate the age based on the "birthdate" column and the current date
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());


-- Query to find the minimum and maximum age from the "hr" table
SELECT
    MIN(age) AS youngest,
    MAX(age) AS oldest
FROM hr;

-- Query to count the number of records where age is less than 18
SELECT COUNT(*) FROM hr WHERE age < 18;

-- Query to count the number of records where termdate is greater than the current date
SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();


-- Query to count the number of records where termdate is '0000-00-00'
SELECT COUNT(*)
FROM hr
WHERE termdate = '0000-00-00';


SELECT location FROM hr;

SELECT * FROM hr;
