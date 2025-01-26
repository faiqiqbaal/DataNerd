# Background
This project focuses on analyzing job postings for data analysts in the United States in 2023 using SQL. The goal was to uncover trends in salaries, in-demand skills, and job roles to provide valuable insights for data professionals and job seekers. This analysis was conducted using PostgreSQL as the database and Visual Studio Code (VSC) as the development environment.

### Five Key Questions that is Analysis Aimed to Solve: 

1. What are the highest-paying data analyst jobs in the United States in 2023?
2. What are the most in-demand skills for data analysts?
3. What are the most demanding skills for data analysts in the US?
4. What tools/skills are associated with higher salaries? 
5. How do the most optimal skills to learn for data analysts in the US?

# Tools I Used For This Analysis
 To delve deep into the data analyst job market and extract trustworthy insights, I harnessed following powerful tools

- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **Visual Studio Code (VSC)**: My go-to for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scropts and analysis, ensuring collaboration and project tracking.

# The Analysis

This analysis was conducted by a data enthusiast committed to leveraging modern tools and techniques to extract meaningful insights from job market data. With a focus on both technical precision and industry relevance, the analysis aims to bridge the gap between data and actionable recommendations. Here is how I approached each question: 

### 1. Highest-Paying Data Analyst Postions in the US

To identify the top-paying data analyst roles in the United States, this query filters positions by average yearly salary and location. It focuses on the 25 highest-paid roles that are specified within the dataset to include job titles, companies, and salary details. The results emphasize the premium job opportunities available for data analysts.

``` sql
-- Query to find the top 25 highest paying data analyst jobs in the United States
SELECT
    job_id, 
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL 
    AND job_location = 'United States'
ORDER BY salary_year_avg DESC
LIMIT 25
``` 

### 2. Skills Required for Top-Paying Data Analyst Jobs in the U.S.

To uncover the skills essential for the top-paying data analyst roles in the U.S., this query analyzes the top 10 highest-paid positions, extracting the specific skills required. The findings help pinpoint the most in-demand competencies for high-salary data analyst jobs, highlighting the value of skills like Tableau, Python, and SQL in the current job market.

``` sql
WITH top_paying_jobs AS (
    SELECT
        job_id, 
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND job_location = 'United States'
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)
SELECT 
    DISTINCT skills_dim.skills,
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg,
    top_paying_jobs.company_name
FROM 
    skills_job_dim
INNER JOIN top_paying_jobs ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC
```

### 3. Most In-Demand Skills for Data Analysts in the USA 
To determine the most in-demand skills for data analysts in the USA, this query examines all relevant job postings, identifying the top 5 skills that appear most frequently. It provides critical insights into the current job market, highlighting essential skills like SQL, Excel, Tableau, Python, and SAS that are crucial for data analysts seeking competitive positions.

``` sql
-- Query to find the top 5 in-demand skills for data analysts in the USA
SELECT 
    skills as skill_in_demand,
    COUNT(skills_job_dim.skill_id) AS skill_count
FROM 
    job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND job_country = 'United States'
GROUP BY
    skill_in_demand
ORDER BY 
    skill_count DESC
LIMIT 5
```
### 4. Top Skills Based on Salary for Data Analysts in the USA
To analyze how different skills impact salary levels for data analysts in the USA, this query calculates the average salary associated with each skill across specified salary data. It identifies the most lucrative skills, such as Dplyr, Solidity, and Hugging Face, which lead to higher salaries, highlighting the demand for expertise in areas like R programming, blockchain, and NLP technologies.

``` sql
-- Query to find the top skills based on salary for Data Analysts
SELECT 
    skills as skill_in_demand,
    ROUND(Avg(salary_year_avg), 0) as avg_salary
FROM 
    job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL 
    AND job_country = 'United States'
GROUP BY
    skill_in_demand
ORDER BY 
    avg_salary DESC
LIMIT 25
```

### 5. Optimal Skills for Data Analysts in the USA: High Demand and High Pay
To identify the most optimal skills for data analysts in the USA, this query cross-references skills that are both high in demand and associated with high average salaries, specifically for remote positions. It focuses on combining job security with financial benefits, offering strategic insights for data analysts aiming to enhance their career prospects by acquiring both highly sought-after and financially rewarding skills.

```sql
-- Query to find the optimal skills for data analysts in the USA based on demand and average salary
WITH skills_demand AS (
    SELECT 
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) as demand_count
    FROM job_postings_fact 
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst' 
        AND job_postings_fact.salary_year_avg IS NOT NULL 
        AND job_postings_fact.job_country = 'United States' 
        AND job_postings_fact.job_work_from_home = 'TRUE'
    GROUP BY
        skills_job_dim.skill_id,
        skills_dim.skills
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        skills_dim.skills, 
        ROUND(Avg(job_postings_fact.salary_year_avg), 0) as avg_salary
    FROM job_postings_fact 
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst' 
        AND job_postings_fact.salary_year_avg IS NOT NULL 
        AND job_postings_fact.job_country = 'United States'
        AND job_postings_fact.job_work_from_home = 'Yes'
    GROUP BY
        skills_job_dim.skill_id,
        skills_dim.skills
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id

ORDER BY demand_count DESC, avg_salary DESC
LIMIT 25
```
