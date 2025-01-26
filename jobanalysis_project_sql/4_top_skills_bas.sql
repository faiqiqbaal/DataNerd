/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions in the USA 
- Focuses on roles with specified salaries, regardless of location 
- Solution? It will reveal how different skills can impact salary levels 
  for Data Analysts and help identify the highest-paying skills that will lead to higher salaries 
*/

-- Query to find the top skills based on salary for Data Analysts in the USA
SELECT 
    skills as skill_in_demand,
    ROUND(Avg(salary_year_avg), 0) as avg_salary
FROM 
    job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND salary_year_avg IS NOT NULL AND job_country = 'United States'
GROUP BY
    skill_in_demand
ORDER BY 
    avg_salary DESC
LIMIT 25

/*
Top Skill: Dplyr offers the highest average salary at $196,250, showcasing demand for R proficiency in data manipulation.
Emerging Trends: Solidity and Hugging Face highlight the importance of blockchain and NLP technologies in analytics.
Technical Tools: Skills like Ansible, Couchbase, and Kafka reflect a rising need for cloud, DevOps, and data pipeline expertise.


Programming Languages: Golang, Rust, and Perl demonstrate the value of specialized languages in data analysis.


[
  {
    "skill_in_demand": "dplyr",
    "avg_salary": "196250"
  },
  {
    "skill_in_demand": "solidity",
    "avg_salary": "179000"
  },
  {
    "skill_in_demand": "hugging face",
    "avg_salary": "175000"
  },
  {
    "skill_in_demand": "bitbucket",
    "avg_salary": "163161"
  },
  {
    "skill_in_demand": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skill_in_demand": "ansible",
    "avg_salary": "159640"
  },
  {
    "skill_in_demand": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skill_in_demand": "mxnet",
    "avg_salary": "149000"
  },
  {
    "skill_in_demand": "cassandra",
    "avg_salary": "148931"
  },
  {
    "skill_in_demand": "vmware",
    "avg_salary": "147500"
  },
  {
    "skill_in_demand": "golang",
    "avg_salary": "145000"
  },
  {
    "skill_in_demand": "twilio",
    "avg_salary": "138500"
  },
  {
    "skill_in_demand": "rust",
    "avg_salary": "138250"
  },
  {
    "skill_in_demand": "keras",
    "avg_salary": "137020"
  },
  {
    "skill_in_demand": "notion",
    "avg_salary": "133125"
  },
  {
    "skill_in_demand": "perl",
    "avg_salary": "132119"
  },
  {
    "skill_in_demand": "puppet",
    "avg_salary": "129820"
  },
  {
    "skill_in_demand": "kafka",
    "avg_salary": "127430"
  },
  {
    "skill_in_demand": "pytorch",
    "avg_salary": "125182"
  },
  {
    "skill_in_demand": "dynamodb",
    "avg_salary": "123333"
  },
  {
    "skill_in_demand": "airflow",
    "avg_salary": "122718"
  },
  {
    "skill_in_demand": "node",
    "avg_salary": "122500"
  },
  {
    "skill_in_demand": "swift",
    "avg_salary": "122500"
  },
  {
    "skill_in_demand": "pyspark",
    "avg_salary": "120569"
  },
  {
    "skill_in_demand": "elasticsearch",
    "avg_salary": "119333"
  }
] */