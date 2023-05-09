-- Questions

-- 1. What is the gender breakdown of employees in the company?
SELECT gender,
Count(*) AS count
FROM hr
WHERE age>=18 AND termdate ='0000-00-00'
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race,
Count(*) AS count
FROM hr
WHERE age>=18 AND termdate ='0000-00-00'
GROUP BY race
ORDER BY count DESC; 

-- 3. What is the age distribution of employees in the company?
SELECT
MIN(AGE) AS youngest,
MAX(AGE) AS OLDEST
From hr
WHERE age>=18 AND termdate ='0000-00-00';

SELECT 
    CASE
       WHEN age>=18 and age<=24 THEN '18-24'
       WHEN age>=25 and age<=34 THEN '25-34'
       WHEN age>=35 and age<=44 THEN '35-44'
       WHEN age>=45 and age<=54 THEN '45-54'
       WHEN age>=55 and age<=64 THEN '55-64'
       ELSE '65+'
 END AS age_group,
 count(*) AS count
FROM hr 
WHERE age>=18 AND termdate ='0000-00-00'
GROUP BY age_group
ORDER BY age_group;

SELECT 
    CASE
       WHEN age>=18 and age<=24 THEN '18-24'
       WHEN age>=25 and age<=34 THEN '25-34'
       WHEN age>=35 and age<=44 THEN '35-44'
       WHEN age>=45 and age<=54 THEN '45-54'
       WHEN age>=55 and age<=64 THEN '55-64'
       ELSE '65+'
 END AS age_group,gender,
 count(*) AS count
FROM hr 
WHERE age>=18 AND termdate ='0000-00-00'
GROUP BY age_group,gender
ORDER BY age_group, gender;

-- 4. How many employees work at headquarters vs remote locations?
SELECT location, 
Count(*) AS count
FROM hr
WHERE age>=18 AND termdate ='0000-00-00'
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT
  round(avg(datediff(termdate,hire_date))/365,0) AS avg_len_employment
FROM hr
WHERE termdate<=curdate() AND termdate <> '0000-00-00' AND age>18;  

-- 6. How does the gender distribution vary across departments and job tittles?
SELECT department, gender,
 count(*) AS count
 FROM hr
WHERE age>=18 AND termdate ='0000-00-00'
GROUP BY department,gender
ORDER BY department;

-- 7. What is the distribution of job tittles across the company?
SELECT jobtitle,
count(*) AS count
From hr
WHERE age>=18 AND termdate ='0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest turnover rate?
SELECT department,
  total_count,
  terminated_count,
  terminated_count/total_count AS termination_rate
FROM(
   SELECT department,
   count(*) AS total_count,
   SUM(CASE WHEN termdate<>'0000-00-00' AND termdate <=curdate() 
   THEN 1 ELSE 0 END) AS terminated_count
   FROM hr
   WHERE age>18
   group by DEPARTMENT) AS subquery
 ORDER BY termination_rate DESC;  
 
 -- 9. What is the distribution of eployees across locations by city and state?
 SELECT location_state,
 COunt(*) AS count
 FROM hr
 WHERE age>=18 AND termdate ='0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employee count changed overtime based on hire and term dates?
SELECT
  year,
  hires,
  terminations,
  hires-terminations AS net_change,
  round((hires-terminations)/hires * 100,2) AS net_change_percent
FROM(
    SELECT YEAR(hire_date) as year,
    count(*) AS hires,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate<= curdate()
 THEN 1 ELSE 0 END) AS terminations
 FROM hr
 WHERE age>=18 
GROUP BY YEAR(hire_date)
)AS subquery
ORDER BY YEAR ASC;

-- 11.What is the tenure distribution for each department?
SELECT department,
round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hr
Where termdate<=curdate()AND termdate <> '0000-00-00' AND age>=18
group by department;





 
       


