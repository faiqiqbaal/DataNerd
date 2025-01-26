/* 
Question: What skills are required for the top-paying data analyst jobs in the United States?
- Use the top 10 highest paying data analyst jobs as a reference.
- Add the specific skills required for these positions.
- Soultions: It provides a detailed look at which high-paying jobs demand certain skills, 
helping job seekers understand the skill sets needed for top-tier positions.
*/

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

/* Insights from the Analysis:
Top Skills:
Tableau (6 mentions) is the most frequently listed skill, followed by:
Python (5 mentions), Power BI (4 mentions), and SQL (4 mentions).
Specialized Tools:
Tools like Snowflake, Excel, and Looker are moderately mentioned.
Unique Mentions:
Skills like Go and SPSS appear less frequently.

[
  {
    "skills": "go",
    "job_id": 4635,
    "job_title": "Research Scientist / Research Engineer (Greater NYC Area, NY)",
    "salary_year_avg": "220000",
    "company_name": "MosaicML"
  },
  {
    "skills": "pytorch",
    "job_id": 4635,
    "job_title": "Research Scientist / Research Engineer (Greater NYC Area, NY)",
    "salary_year_avg": "220000",
    "company_name": "MosaicML"
  },
  {
    "skills": "atlassian",
    "job_id": 386558,
    "job_title": "Director, Data Analytics & Insights",
    "salary_year_avg": "190000",
    "company_name": "Believe"
  },
  {
    "skills": "jira",
    "job_id": 386558,
    "job_title": "Director, Data Analytics & Insights",
    "salary_year_avg": "190000",
    "company_name": "Believe"
  },
  {
    "skills": "power bi",
    "job_id": 386558,
    "job_title": "Director, Data Analytics & Insights",
    "salary_year_avg": "190000",
    "company_name": "Believe"
  },
  {
    "skills": "python",
    "job_id": 386558,
    "job_title": "Director, Data Analytics & Insights",
    "salary_year_avg": "190000",
    "company_name": "Believe"
  },
  {
    "skills": "tableau",
    "job_id": 386558,
    "job_title": "Director, Data Analytics & Insights",
    "salary_year_avg": "190000",
    "company_name": "Believe"
  },
  {
    "skills": "unity",
    "job_id": 1367292,
    "job_title": "Clinical Scientist, Neuroimaging",
    "salary_year_avg": "169833.5",
    "company_name": "Denali Therapeutics"
  },
  {
    "skills": "azure",
    "job_id": 15709,
    "job_title": "Analytics Engineer II",
    "salary_year_avg": "147500",
    "company_name": "Gopuff"
  },
  {
    "skills": "git",
    "job_id": 15709,
    "job_title": "Analytics Engineer II",
    "salary_year_avg": "147500",
    "company_name": "Gopuff"
  },
  {
    "skills": "looker",
    "job_id": 15709,
    "job_title": "Analytics Engineer II",
    "salary_year_avg": "147500",
    "company_name": "Gopuff"
  },
  {
    "skills": "redshift",
    "job_id": 15709,
    "job_title": "Analytics Engineer II",
    "salary_year_avg": "147500",
    "company_name": "Gopuff"
  },
  {
    "skills": "snowflake",
    "job_id": 15709,
    "job_title": "Analytics Engineer II",
    "salary_year_avg": "147500",
    "company_name": "Gopuff"
  },
  {
    "skills": "sql",
    "job_id": 15709,
    "job_title": "Analytics Engineer II",
    "salary_year_avg": "147500",
    "company_name": "Gopuff"
  },
  {
    "skills": "c#",
    "job_id": 70981,
    "job_title": "Energy Data Analyst",
    "salary_year_avg": "119550",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "skills": "c++",
    "job_id": 70981,
    "job_title": "Energy Data Analyst",
    "salary_year_avg": "119550",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "skills": "perl",
    "job_id": 70981,
    "job_title": "Energy Data Analyst",
    "salary_year_avg": "119550",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "skills": "python",
    "job_id": 70981,
    "job_title": "Energy Data Analyst",
    "salary_year_avg": "119550",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "skills": "qlik",
    "job_id": 70981,
    "job_title": "Energy Data Analyst",
    "salary_year_avg": "119550",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "skills": "r",
    "job_id": 70981,
    "job_title": "Energy Data Analyst",
    "salary_year_avg": "119550",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "skills": "sas",
    "job_id": 70981,
    "job_title": "Energy Data Analyst",
    "salary_year_avg": "119550",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "skills": "spss",
    "job_id": 70981,
    "job_title": "Energy Data Analyst",
    "salary_year_avg": "119550",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "skills": "tableau",
    "job_id": 70981,
    "job_title": "Energy Data Analyst",
    "salary_year_avg": "119550",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "skills": "excel",
    "job_id": 124123,
    "job_title": "Data Analyst, Operations Engineering",
    "salary_year_avg": "118640",
    "company_name": "Invenergy"
  },
  {
    "skills": "power bi",
    "job_id": 124123,
    "job_title": "Data Analyst, Operations Engineering",
    "salary_year_avg": "118640",
    "company_name": "Invenergy"
  },
  {
    "skills": "sql",
    "job_id": 124123,
    "job_title": "Data Analyst, Operations Engineering",
    "salary_year_avg": "118640",
    "company_name": "Invenergy"
  },
  {
    "skills": "looker",
    "job_id": 999982,
    "job_title": "Director, Customer Success Data Analytics",
    "salary_year_avg": "116950",
    "company_name": "Emburse"
  },
  {
    "skills": "snowflake",
    "job_id": 999982,
    "job_title": "Director, Customer Success Data Analytics",
    "salary_year_avg": "116950",
    "company_name": "Emburse"
  },
  {
    "skills": "tableau",
    "job_id": 999982,
    "job_title": "Director, Customer Success Data Analytics",
    "salary_year_avg": "116950",
    "company_name": "Emburse"
  },
  {
    "skills": "power bi",
    "job_id": 1218751,
    "job_title": "Data Science Analyst",
    "salary_year_avg": "112350",
    "company_name": "Greater New York Mutual Insurance Company"
  },
  {
    "skills": "python",
    "job_id": 1218751,
    "job_title": "Data Science Analyst",
    "salary_year_avg": "112350",
    "company_name": "Greater New York Mutual Insurance Company"
  },
  {
    "skills": "r",
    "job_id": 1218751,
    "job_title": "Data Science Analyst",
    "salary_year_avg": "112350",
    "company_name": "Greater New York Mutual Insurance Company"
  },
  {
    "skills": "sql",
    "job_id": 1218751,
    "job_title": "Data Science Analyst",
    "salary_year_avg": "112350",
    "company_name": "Greater New York Mutual Insurance Company"
  },
  {
    "skills": "tableau",
    "job_id": 1218751,
    "job_title": "Data Science Analyst",
    "salary_year_avg": "112350",
    "company_name": "Greater New York Mutual Insurance Company"
  },
  {
    "skills": "vba",
    "job_id": 1218751,
    "job_title": "Data Science Analyst",
    "salary_year_avg": "112350",
    "company_name": "Greater New York Mutual Insurance Company"
  },
  {
    "skills": "aws",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "java",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "mysql",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "postgresql",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "power bi",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "python",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "ruby",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "scala",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "sql",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "sql server",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "tableau",
    "job_id": 321008,
    "job_title": "Data Analyst",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "skills": "excel",
    "job_id": 572735,
    "job_title": "Data Analyst",
    "salary_year_avg": "110000",
    "company_name": "Insight Global"
  },
  {
    "skills": "python",
    "job_id": 572735,
    "job_title": "Data Analyst",
    "salary_year_avg": "110000",
    "company_name": "Insight Global"
  },
  {
    "skills": "tableau",
    "job_id": 572735,
    "job_title": "Data Analyst",
    "salary_year_avg": "110000",
    "company_name": "Insight Global"
  }
]
*/

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
        job_title_short = 'Data Scientist' AND
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

    /*
Insights from the Data Scientist Skills Analysis:
Top Skills:
Python (9 mentions) dominates as the most commonly listed skill.
Spark (6 mentions) and Snowflake (4 mentions) are also highly sought after.
Key Tools and Frameworks:
Databricks, SQL, and AWS appear frequently, highlighting their importance in data scientist roles.
Machine Learning Libraries:
Libraries like Numpy and Scikit-learn show up, emphasizing technical expertise.
    [
  {
    "skills": "aws",
    "job_id": 1601809,
    "job_title": "Vice President of Data Platforms and Data Science",
    "salary_year_avg": "275000",
    "company_name": "Harnham"
  },
  {
    "skills": "azure",
    "job_id": 1601809,
    "job_title": "Vice President of Data Platforms and Data Science",
    "salary_year_avg": "275000",
    "company_name": "Harnham"
  },
  {
    "skills": "databricks",
    "job_id": 1601809,
    "job_title": "Vice President of Data Platforms and Data Science",
    "salary_year_avg": "275000",
    "company_name": "Harnham"
  },
  {
    "skills": "go",
    "job_id": 1601809,
    "job_title": "Vice President of Data Platforms and Data Science",
    "salary_year_avg": "275000",
    "company_name": "Harnham"
  },
  {
    "skills": "looker",
    "job_id": 1601809,
    "job_title": "Vice President of Data Platforms and Data Science",
    "salary_year_avg": "275000",
    "company_name": "Harnham"
  },
  {
    "skills": "python",
    "job_id": 1601809,
    "job_title": "Vice President of Data Platforms and Data Science",
    "salary_year_avg": "275000",
    "company_name": "Harnham"
  },
  {
    "skills": "snowflake",
    "job_id": 1601809,
    "job_title": "Vice President of Data Platforms and Data Science",
    "salary_year_avg": "275000",
    "company_name": "Harnham"
  },
  {
    "skills": "python",
    "job_id": 187068,
    "job_title": "Director of Data Science",
    "salary_year_avg": "269000",
    "company_name": "Komodo Health"
  },
  {
    "skills": "snowflake",
    "job_id": 187068,
    "job_title": "Director of Data Science",
    "salary_year_avg": "269000",
    "company_name": "Komodo Health"
  },
  {
    "skills": "spark",
    "job_id": 187068,
    "job_title": "Director of Data Science",
    "salary_year_avg": "269000",
    "company_name": "Komodo Health"
  },
  {
    "skills": "sql",
    "job_id": 187068,
    "job_title": "Director of Data Science",
    "salary_year_avg": "269000",
    "company_name": "Komodo Health"
  },
  {
    "skills": "python",
    "job_id": 5555,
    "job_title": "VP, Data Science",
    "salary_year_avg": "265500",
    "company_name": "MediaMath"
  },
  {
    "skills": "scala",
    "job_id": 5555,
    "job_title": "VP, Data Science",
    "salary_year_avg": "265500",
    "company_name": "MediaMath"
  },
  {
    "skills": "spark",
    "job_id": 5555,
    "job_title": "VP, Data Science",
    "salary_year_avg": "265500",
    "company_name": "MediaMath"
  },
  {
    "skills": "hadoop",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "matplotlib",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "numpy",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "pandas",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "python",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "r",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "scala",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "scikit-learn",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "seaborn",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "spark",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "sql",
    "job_id": 204505,
    "job_title": "Director Data Science",
    "salary_year_avg": "255000",
    "company_name": "nitruc"
  },
  {
    "skills": "python",
    "job_id": 374003,
    "job_title": "Principal Data Scientist - BCG X & BCG Fed (Pittsburgh, PA)",
    "salary_year_avg": "253000",
    "company_name": "BCG X"
  },
  {
    "skills": "spark",
    "job_id": 374003,
    "job_title": "Principal Data Scientist - BCG X & BCG Fed (Pittsburgh, PA)",
    "salary_year_avg": "253000",
    "company_name": "BCG X"
  },
  {
    "skills": "aws",
    "job_id": 980329,
    "job_title": "Vice President of Data Platforms & Data Science",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "azure",
    "job_id": 980329,
    "job_title": "Vice President of Data Platforms & Data Science",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "databricks",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  },
  {
    "skills": "databricks",
    "job_id": 980329,
    "job_title": "Vice President of Data Platforms & Data Science",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "go",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  },
  {
    "skills": "go",
    "job_id": 980329,
    "job_title": "Vice President of Data Platforms & Data Science",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "hadoop",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  },
  {
    "skills": "kafka",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  },
  {
    "skills": "looker",
    "job_id": 980329,
    "job_title": "Vice President of Data Platforms & Data Science",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "neo4j",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  },
  {
    "skills": "nosql",
    "job_id": 462298,
    "job_title": "PRINCIPAL DATA SCIENTIST",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "numpy",
    "job_id": 675919,
    "job_title": "Head of Clinical Data Science",
    "salary_year_avg": "250000",
    "company_name": "Sumner & Scott"
  },
  {
    "skills": "pandas",
    "job_id": 675919,
    "job_title": "Head of Clinical Data Science",
    "salary_year_avg": "250000",
    "company_name": "Sumner & Scott"
  },
  {
    "skills": "plotly",
    "job_id": 462298,
    "job_title": "PRINCIPAL DATA SCIENTIST",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "power bi",
    "job_id": 462298,
    "job_title": "PRINCIPAL DATA SCIENTIST",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "power bi",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  },
  {
    "skills": "python",
    "job_id": 462298,
    "job_title": "PRINCIPAL DATA SCIENTIST",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "python",
    "job_id": 675919,
    "job_title": "Head of Clinical Data Science",
    "salary_year_avg": "250000",
    "company_name": "Sumner & Scott"
  },
  {
    "skills": "python",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  },
  {
    "skills": "python",
    "job_id": 980329,
    "job_title": "Vice President of Data Platforms & Data Science",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "r",
    "job_id": 675919,
    "job_title": "Head of Clinical Data Science",
    "salary_year_avg": "250000",
    "company_name": "Sumner & Scott"
  },
  {
    "skills": "scikit-learn",
    "job_id": 675919,
    "job_title": "Head of Clinical Data Science",
    "salary_year_avg": "250000",
    "company_name": "Sumner & Scott"
  },
  {
    "skills": "snowflake",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  },
  {
    "skills": "snowflake",
    "job_id": 980329,
    "job_title": "Vice President of Data Platforms & Data Science",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "spark",
    "job_id": 462298,
    "job_title": "PRINCIPAL DATA SCIENTIST",
    "salary_year_avg": "250000",
    "company_name": "Harnham"
  },
  {
    "skills": "spark",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  },
  {
    "skills": "sql",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  },
  {
    "skills": "tableau",
    "job_id": 868818,
    "job_title": "Principal, Data Scientist, Knowledge Management",
    "salary_year_avg": "250000",
    "company_name": "Intelletec"
  }
]