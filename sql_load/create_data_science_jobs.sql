Select job_title_short, job_location,job_posted_date::DATE AS date
FROM job_postings_fact LIMIT 5

Select job_title_short, job_location,job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS EST 
FROM job_postings_fact LIMIT 5

Select job_title_short,job_location,extract(MONTH FROM job_posted_date) AS MOnth

FROM job_postings_fact LIMIT 5

CREATE TABLE data_science_jobs (job_id INT PRIMARY KEY,
job_title TEXT, company_name TEXT, post_date DATE)

INSERT INTO data_science_jobs ( job_id,job_title, company_name, post_date) 
VALUES (1,'Data Scientist', 'Tech Innovations', '01/01/2023'), 
(2, 'Machine Learning Engineer', 'Data Driven Co', '01/15/2023'),
(3, 'AI Specialist', 'Future Tech', '02/1/2023')

ALTER TABLE data_science_jobs ADD COLUMN remote BOOLEAN


Select * FROM data_science_jobs LIMIT 5

ALTER TABLE data_science_jobs
RENAME COLUMN post_date to posted_on

ALTER TABLE data_science_jobs
ALTER COLUMN remote SET DEFAULT FALSE

ALTER TABLE data_science_jobs
DROP COLUMN company_name  

UPDATE data_science_jobs SET remote = TRUE WHERE job_id=2

CREATE TABLE data_science_job (job_id INT PRIMARY KEY,
job_title TEXT, company_name TEXT, post_date DATE)

DROP TABLE data_science_job

Select 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category
ORDER BY number_of_jobs DESC

Select
    job_id, job_title,salary_year_avg,
    CASE
        WHEN salary_year_avg > 100000 THEN 'High Salary'
        WHEN salary_year_avg BETWEEN 60000 and 99999 THEN 'Standard Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
ORDER BY salary_year_avg
LIMIT 10

Select
    COUNT(Distinct CASE WHEN job_work_from_home = TRUE THEN company_id END) as wfh_companies,
    COUNT(Distinct CASE WHEN job_work_from_home = FALSE THEN company_id END) AS non_wfh_companies
FROM job_postings_fact

Select
    job_id, 
    salary_year_avg,
    CASE 
        WHEN job_title ILIKE '%Senior%' THEN 'Senior'
        WHEN job_title ILIKE '%Manager%' OR job_title ILIKE '%Lead%' THEN 'Lead/Manager'
        WHEN job_title ILIKE '%Junior%' OR job_title ILIKE '%Entry%' THEN 'Junior/Entry'
        ELSE 'Not-Specified'
    END AS experience_level,
    CASE 
        WHEN job_work_from_home = TRUE THEN 'YES'
        WHEN job_work_from_home = FALSE THEN 'NO'
    END AS remote_option
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL

Select
    company_id,
    name as company_name
FROM
    company_dim
WHERE company_id (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE job_no_degree_mention = TRUE
    ORDER BY
        company_id 
)

SELECT skills_dim.skills
FROM skills_dim 
INNER JOIN (
    SELECT skill_id, COUNT(skill_id) skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY COUNT(job_id) DESC
) AS top_skills ON skills_dim.skill_id = top_skills.skill_id
ORDER BY top_skills.skill_count DESC
LIMIT 5

--Determine the size category ('Small', 'Medium', or 'Large') for each company by first identifying the number of job postings they have. 
--Use a subquery to calculate the total job postings per company. 
--A company is considered 'Small' if it has less than 10 job postings, 'Medium' if the number of job postings is between 10 and 50, 
  --and 'Large' if it has more than 50 job postings.
-- Implement a subquery to aggregate job counts per company before classifying them based on size.

SELECT company_id,name,
    CASE
        WHEN count_jobs <10 THEN 'Small'
        WHEN count_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS size_category
FROM (
    SELECT 
        company_dim.company_id,
        company_dim.name,
        COUNT(job_id) AS count_jobs
    FROM company_dim
    INNER JOIN job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
    GROUP BY company_dim.company_id, company_dim.name
) AS job_count_per_company


--Determine each company's size category ('Small', 'Medium', or 'Large') by the number of job postings they have. 
--Classify them as 'Small' if less than 10 job postings, 'Medium' if between 10 and 50, and 'Large' if more than 50.

SELECT company_dim.company_id, company_dim.name,
    CASE
    END AS
FROM company_dim

--Find companies that offer an average salary above the overall average yearly salary of all job postings.
-- Use subqueries to select companies with an average salary higher than the overall average salary (which is another subquery).

SELECT company_dim.company_id, company_dim.name
FROM company_dim
INNER JOIN (
    SELECT job_postings_fact.company_id, avg(job_postings_fact.salary_year_avg) AS avg_salary 
    FROM job_postings_fact
    GROUP BY company_id
) AS avg_yearly_salary ON company_dim.company_id = avg_yearly_salary.company_id
WHERE avg_yearly_salary.avg_salary > (
    SELECT AVG(salary_year_avg)
    FROM job_postings_fact
)

--Identify companies with the most diverse (unique) job titles. 
--Use a CTE to count the number of unique job titles per company,
-- then select companies with the highest diversity in job titles.

WITH diverse_title AS (
    SELECT 
    company_id,
    COUNT(Distinct job_title) AS unique_titles
    FROM 
        job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.company_id, company_dim.name, diverse_title.unique_titles
FROM company_dim
INNER JOIN diverse_title ON company_dim.company_id = diverse_title.company_id
ORDER BY unique_titles DESC
LIMIT 10

SELECT Distinct(job_country) FROM job_postings_fact

--Explore job postings by listing job id, job titles, company names, and their average salary rates, 
--while categorizing these salaries relative to the average in their respective countries.
--Include the month of the job posted date. Use CTEs, conditional logic, and date functions, to compare individual salaries with national averages.\


WITH national_avg AS (
    SELECT
        job_country, 
        avg(salary_year_avg) AS country_avg_salary
    FROM job_postings_fact
    GROUP BY job_country
)
SELECT 
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.salary_year_avg AS salary_avg,
    CASE 
        WHEN job_postings_fact.salary_year_avg > national_avg.country_avg_salary THEN 'Above  Average'
        ELSE 'Below Average'
    END AS salary_category,
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date) posting_month
FROM job_postings_fact

INNER JOIN company_dim ON job_postings_fact.company_id  = company_dim.company_id
INNER JOIN national_avg ON job_postings_fact.job_country = national_avg.job_country
WHERE job_postings_fact.salary_year_avg IS NOT NULL
ORDER BY posting_month DESC


--Calculate the number of unique skills required by each company. 
--Aim to quantify the unique skills required per company and 
--identify which of these companies offer the highest average salary for positions necessitating at least one skill.
--For entities without skill-related job postings, list it as a zero skill requirement and a null salary. 
--Use CTEs to separately assess the unique skill count and the maximum average salary offered by these companies.


WITH required_skills AS (
    SELECT
        c.company_id,
        c.name, 
        COUNT(Distinct sk.skills) unique_skills
    FROM company_dim c
    LEFT JOIN job_postings_fact jpf ON c.company_id = jpf.company_id
    LEFT JOIN skills_job_dim skj ON jpf.job_id = skj.job_id
    LEFT JOIN skills_dim sk ON skj.skill_id = sk.skill_id
    GROUP BY c.company_id, c.name
),
 max_salary AS (
    SELECT 
        jpf.company_id,
        MAX(jpf.salary_year_avg) AS highest_avg_salary
    FROM job_postings_fact jpf
    WHERE jpf.job_id IN (SELECT job_id FROM skills_job_dim)
    GROUP by jpf.company_id
)
SELECT 
    c.name,
    required_skills.unique_skills,
    max_salary.highest_avg_salary
FROM company_dim c
LEFT JOIN required_skills ON c.company_id = required_skills.company_id
LEFT JOIN max_salary ON c.company_id = max_salary.company_id
ORDER BY c.name ASC






