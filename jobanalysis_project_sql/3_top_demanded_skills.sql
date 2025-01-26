/*
Question: WHat are the most in-demand skills for the data analysts in USA?
- join job posstings to inner join table similar to query 2
- identify the top 5 in-demand skills for data analysts
- Forcus on all job postings
- Solution? Retrieves the top 5 skills with the highest demand in the job market
  Provide insights into the most valuable skills for job seekers
*/


-- Query to find the top 5 in-demand skills for data analysts in the USA
SELECT 
    skills as skill_in_demand,
    COUNT(skills_job_dim.skill_id) AS skill_count
FROM 
    job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND job_country = 'United States'
GROUP BY
    skill_in_demand
ORDER BY 
    skill_count DESC
LIMIT 5

/*
Insights into the Top 5 In-Demand Skills for Data Analysts in 2023:
SQL Dominance:

SQL is the most in-demand skill with 34,505 job postings, underscoring its importance as a core tool for database querying and manipulation.
Traditional Tools Still Matter:

Excel, with 27,576 postings, highlights the continued reliance on spreadsheet tools for data analysis despite advancements in more sophisticated software.
Visualization and Advanced Analytics:

Tableau (19,350 postings) and Python (18,411 postings) indicate the industry's emphasis on data visualization and advanced programming for analytics and machine learning.
Specialized Tools:

SAS, with 13,256 postings, remains relevant for industries like healthcare and finance that require statistical analysis and compliance with stringent regulatory standards.

[
  {
    "skill_in_demand": "sql",
    "skill_count": "34505"
  },
  {
    "skill_in_demand": "excel",
    "skill_count": "27576"
  },
  {
    "skill_in_demand": "tableau",
    "skill_count": "19350"
  },
  {
    "skill_in_demand": "python",
    "skill_count": "18411"
  },
  {
    "skill_in_demand": "sas",
    "skill_count": "13256"
  }
]
*/