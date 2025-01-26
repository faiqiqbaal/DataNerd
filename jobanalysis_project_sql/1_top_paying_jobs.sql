/* 
What are the top-paying data analyst jobs in the United States?
- Identify the top 25 highest paying data analyst jobs in the United States.
- Focuses on job postings with specified salaries (remove null values).
- The results should include the job title, company name, location, salary, and job description.
*/

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

/* 
Insights into Top 25 Highest-Paying Data Analyst Jobs in the US (2023):
1. Top-Paying Jobs:
MosaicML offers the highest salary ($220,000) for a Research Scientist / Engineer role, emphasizing the value of hybrid analytics and engineering expertise.
2. Common Job Titles:
Roles such as Director of Data Analytics and Data Science Analyst highlight leadership and advanced analytical positions commanding competitive pay.
3. Trends by Job Type:
Most positions are full-time, with part-time and contractor roles averaging slightly lower pay.
Hybrid roles like Analytics Engineer or Energy Data Analyst demonstrate rising demand for cross-functional skills.

[
  {
    "job_id": 4635,
    "job_title": "Research Scientist / Research Engineer (Greater NYC Area, NY)",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "220000",
    "company_name": "MosaicML"
  },
  {
    "job_id": 386558,
    "job_title": "Director, Data Analytics & Insights",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "190000",
    "company_name": "Believe"
  },
  {
    "job_id": 1367292,
    "job_title": "Clinical Scientist, Neuroimaging",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "169833.5",
    "company_name": "Denali Therapeutics"
  },
  {
    "job_id": 15709,
    "job_title": "Analytics Engineer II",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "147500",
    "company_name": "Gopuff"
  },
  {
    "job_id": 70981,
    "job_title": "Energy Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "salary_year_avg": "119550",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "job_id": 124123,
    "job_title": "Data Analyst, Operations Engineering",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "118640",
    "company_name": "Invenergy"
  },
  {
    "job_id": 999982,
    "job_title": "Director, Customer Success Data Analytics",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "116950",
    "company_name": "Emburse"
  },
  {
    "job_id": 1218751,
    "job_title": "Data Science Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "112350",
    "company_name": "Greater New York Mutual Insurance Company"
  },
  {
    "job_id": 321008,
    "job_title": "Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "111175",
    "company_name": "Bixal"
  },
  {
    "job_id": 572735,
    "job_title": "Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "110000",
    "company_name": "Insight Global"
  },
  {
    "job_id": 80039,
    "job_title": "Sr. Human Resources Specialist (Data Analytics)",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "107800",
    "company_name": "Nestlé"
  },
  {
    "job_id": 81442,
    "job_title": "Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Contractor",
    "salary_year_avg": "105000",
    "company_name": "Eliassen Group"
  },
  {
    "job_id": 786474,
    "job_title": "Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "100500",
    "company_name": "Govini"
  },
  {
    "job_id": 1440586,
    "job_title": "Session Lead (External Contractor) - Data Analyst Nanodegree...",
    "job_location": "United States",
    "job_schedule_type": "Part-time",
    "salary_year_avg": "100500",
    "company_name": "Udacity, Inc."
  },
  {
    "job_id": 1489686,
    "job_title": "Operational Analytics Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "100000",
    "company_name": "Robinhood"
  },
  {
    "job_id": 764317,
    "job_title": "Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "100000",
    "company_name": "KTek Resourcing"
  },
  {
    "job_id": 1768031,
    "job_title": "Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "90000",
    "company_name": "SpringbokIT"
  },
  {
    "job_id": 830768,
    "job_title": "Technical Data Analyst Job",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "89500",
    "company_name": "PACCAR"
  },
  {
    "job_id": 270241,
    "job_title": "Data Analyst, Asset Management",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "89500",
    "company_name": "Royal Caribbean Group"
  },
  {
    "job_id": 1274039,
    "job_title": "Finance Master Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "89204",
    "company_name": "Nestlé"
  },
  {
    "job_id": 388835,
    "job_title": "Financial Management Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "89118",
    "company_name": "KBR, Inc."
  },
  {
    "job_id": 565950,
    "job_title": "Data Analyst - EdTech",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "87500",
    "company_name": "Analytic Recruiting Inc."
  },
  {
    "job_id": 72936,
    "job_title": "Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "87500",
    "company_name": "Angi"
  },
  {
    "job_id": 928979,
    "job_title": "Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "85000",
    "company_name": "Insight Global"
  },
  {
    "job_id": 108061,
    "job_title": "Health and Safety Professional - IH Data Analyst",
    "job_location": "United States",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "77017.5",
    "company_name": "Oak Ridge National Laboratory"
  }
]
*/