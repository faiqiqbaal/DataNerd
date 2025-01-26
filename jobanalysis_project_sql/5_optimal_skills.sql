/*
Questions: What are the most optimal skills to learn for a data analyst in USA?
- Identify skills in high demand and associated with the ave
- Concentrates on remote positions with specified salaries
- Solution? 
    Targets skills that offer job securiety (high demand) 
    offering strategic insights for career deveopment in the data field

*/

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


/*
Key Insights into Optimal Skills for Data Analysts in 2023:
1. Most In-Demand Skills:
SQL leads with the highest demand (371 postings) and a respectable average salary ($97,656), emphasizing its foundational role in data analysis.
Excel and Python are also highly sought after, with 242 and 217 postings, respectively, showcasing their versatility in analytics workflows.
2. Highest-Paying Skills:
Hadoop commands the highest average salary ($119,012), reflecting the demand for expertise in big data processing.
Snowflake ($112,399) and Azure ($110,660) highlight the growing need for cloud-based data warehousing and processing tools.
3. Emerging and Niche Tools:
Go offers a significant salary bump ($115,320) despite lower demand, suggesting its specialized utility in high-performance computing tasks.
Tools like Jira and Looker, though less demanded, offer competitive salaries ($104,918 and $103,122, respectively), reflecting their niche importance in project management and BI.
[
  {
    "skill_id": 0,
    "skills": "sql",
    "demand_count": "371",
    "avg_salary": "97656"
  },
  {
    "skill_id": 181,
    "skills": "excel",
    "demand_count": "242",
    "avg_salary": "87799"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "217",
    "avg_salary": "101350"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "216",
    "avg_salary": "99978"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "137",
    "avg_salary": "101782"
  },
  {
    "skill_id": 183,
    "skills": "power bi",
    "demand_count": "101",
    "avg_salary": "97455"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 196,
    "skills": "powerpoint",
    "demand_count": "55",
    "avg_salary": "88639"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "45",
    "avg_salary": "103122"
  },
  {
    "skill_id": 188,
    "skills": "word",
    "demand_count": "45",
    "avg_salary": "83492"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "36",
    "avg_salary": "105632"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "34",
    "avg_salary": "112399"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "demand_count": "33",
    "avg_salary": "97727"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "29",
    "avg_salary": "110660"
  },
  {
    "skill_id": 192,
    "skills": "sheets",
    "demand_count": "28",
    "avg_salary": "85618"
  },
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "27",
    "avg_salary": "115320"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "25",
    "avg_salary": "111066"
  },
  {
    "skill_id": 215,
    "skills": "flow",
    "demand_count": "25",
    "avg_salary": "98264"
  },
  {
    "skill_id": 199,
    "skills": "spss",
    "demand_count": "24",
    "avg_salary": "92170"
  },
  {
    "skill_id": 22,
    "skills": "vba",
    "demand_count": "24",
    "avg_salary": "88783"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "demand_count": "20",
    "avg_salary": "119012"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "demand_count": "20",
    "avg_salary": "104918"
  },
  {
    "skill_id": 9,
    "skills": "javascript",
    "demand_count": "19",
    "avg_salary": "99960"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "16",
    "avg_salary": "104901"
  }
]
*/