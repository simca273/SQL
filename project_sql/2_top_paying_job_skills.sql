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
        job_title_short = 'Data Scientist' AND
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
