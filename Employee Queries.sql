USE company;
select * from companies;
select * from jobs;

# 1. What is the highest salary in the dataset and which job role does it correspond to?
SELECT salary, job_title FROM jobs ORDER BY salary DESC LIMIT 1;

# Q2 What is the average salary of data scientists in the US?
SELECT AVG(salary) as avg_salary FROM Jobs 
WHERE job_title ='Data Scientist' AND company_location = 'US' ;

# Q3 What is the number of jobs available for each job title?
SELECT job_title, COUNT(*) as num_jobs from jobs  
GROUP BY job_title;

# Q4 What is the TOP 5 highest paying job titles and their average corresponding salaries ?
 SELECT job_title, avg(salary) as avg_salary FROM jobs
 group by job_title
 order by avg_salary
 desc limit 5;
 
 # 5. What are the top 5 cities with the highest average salaries?*/
 SELECT company_location, AVG(salary) as avg_salary from jobs
 group by company_location
 order by avg_salary desc limit 5;
 
 # 6. What is the average salary for each job title in each location, and what is the total number of jobs available for each job title in each location?
 SELECT job_title, company_location, avg(salary) as avg_salary, count(job_title) as num_jobs
 from jobs
 group by job_title, company_location;
 
# 7. What are the top 5 cities with the highest average salaries, and what is the name of the company that offers the highest salary for each city?
SELECT company_location, AVG(salary) AS average_salary, company_name
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
GROUP BY company_location, company_name
ORDER BY average_salary DESC 
LIMIT 5;

# 8. What is the average salary for each job title in each company, and what is the rank of each job title within each company based on the average salary?

SELECT job_title, company_name, AVG(salary) AS average_salary, 
RANK() OVER (PARTITION BY company_name ORDER BY AVG(salary) DESC) AS salary_rank 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
GROUP BY job_title, company_name;

# 9. What is the total number of jobs available for each job title in each location, and what is the rank of each job title within each location based on the total number of jobs?
SELECT job_title, company_location, COUNT(*) AS num_jobs, 
RANK() OVER (PARTITION BY company_location ORDER BY COUNT(*) DESC) AS job_rank 
FROM jobs 
GROUP BY job_title, company_location;

# 10. What are the top 5 companies with the highest average salaries for data scientist positions, and what is the rank of each company based on the average salary?

SELECT company_name, AVG(salary) AS average_salary, 
RANK() OVER (ORDER BY AVG(salary) DESC) AS salary_rank 
FROM jobs 
INNER JOIN companies ON jobs.id = companies.id 
WHERE job_title = 'Data Scientist' 
GROUP BY company_name 
ORDER BY average_salary DESC 
LIMIT 5;

 
 
