/*
Question: What are the most in_demand skills for data analysts?
- Join job postings to inner join table similar to query 2.
- Identify the top 5 in-demand skills for adata analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
providing insights into the most valuable skills for job seekers.
*/

SELECT 
  skills,
    COUNT(skills_job_dim2.job_id) AS demand_count
FROM job_postings_fact2
INNER JOIN skills_job_dim2
    ON job_postings_fact2.job_id = skills_job_dim2.job_id
INNER JOIN skills_dim2
    ON skills_job_dim2.skill_id = skills_dim2.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5;

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact2
    LEFT JOIN company_dim2
        ON job_postings_fact2.company_id = company_dim2.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
) 

SELECT top_paying_jobs.*,
         skills_dim2.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim2
    ON top_paying_jobs.job_id = skills_job_dim2.job_id
INNER JOIN skills_dim2
    ON skills_job_dim2.skill_id = skills_dim2.skill_id
ORDER BY
   salary_year_avg DESC
LIMIT 5;