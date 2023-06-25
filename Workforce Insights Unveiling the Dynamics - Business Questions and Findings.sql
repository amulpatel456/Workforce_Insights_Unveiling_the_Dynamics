-- 1. What is the gender breakdown of employees in the company?
select *from hr;
SELECT gender, COUNT(*) AS count
FROM hr
where age is not null and termdate = '0000-00-00'
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
select *from hr;
SELECT race, COUNT(*) AS count
FROM hr
where age is not null and termdate = '0000-00-00'
GROUP BY race;

-- 3. What is the age distribution of employees in the company?
SELECT case
when age >= 0 and age <=20 then 'Below 20'
when age >= 21 and age <=30 then '21-30'
when age >= 31 and age <=40 then '31-40'
when age >= 41 and age <=50 then '41-50'
when age >= 51 and age <=60 then '51-60'
else '60+'
end as age_group, gender, COUNT(*) AS count FROM hr
where age is not null and termdate = '0000-00-00'
GROUP BY age_group, gender
order BY age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?
SELECT * FROM hr;
SELECT location, COUNT(*) AS count
FROM hr
where age is not null and termdate = '0000-00-00'
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT AVG(DATEDIFF(termdate, hire_date))/365 AS average_length_of_employment
FROM hr
WHERE termdate <= curdate() and termdate <> '0000-00-00'and  age is not null;

-- 6. How does the gender distribution vary across departments and job titles?
SELECT * FROM hr;
SELECT gender, department, COUNT(*) AS count
FROM hr
where age is not null and termdate = '0000-00-00'
GROUP BY gender, department;

-- 7. What is the distribution of job titles across the company?
SELECT * FROM hr;
SELECT jobtitle, COUNT(*) AS count
FROM hr
where age is not null and termdate = '0000-00-00'
GROUP BY jobtitle;

-- 8. Which department has the highest termination rate?
SELECT * FROM hr;
select department, total_count, terminated_count, terminated_count/total_count as termination_rate
from (
select department,
count(*) as total_count,
sum(case when termdate <> '0000-00-00' and termdate <= curdate()  then 1 else 0 end) as terminated_count
from hr
where age is not null 
group by department
) as subquary
order by termination_rate desc;

-- 9. What is the distribution of employees across locations by state?
SELECT * FROM hr;
SELECT  location_state, count(*) AS count
FROM hr
where age is not null  and termdate = '0000-00-00'
GROUP BY location_state;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT  year,
       hires,
       terminations,
       hires - terminations AS net_change,
      ROUND(( hires - terminations)/hires* 100, 2) AS net_change_percentage
FROM
(
    SELECT year(hire_date) AS year, COUNT(*) AS hires,
    sum(case when termdate <> '0000-00-00' and termdate <= curdate()  then 1 else 0 end) as terminations
    FROM hr
    WHERE age is not null
    GROUP BY year(hire_date)
) AS subquary
GROUP BY YEAR
ORDER BY YEAR;

-- 11. What is the tenure distribution for each department?
select department, round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure
from hr
where age is not null  and termdate <> '0000-00-00' and termdate <= curdate() 
group by department;