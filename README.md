**Introduction**

This  dataset focuses on data-related job market, specifically on data scientists roles. This project will answer questions such as top-paying jobs, demanded skills and where high demand meets high salary in data jobs. The goal was to navigate the data scientists job market more effectively and find top-payed and in-demand skills, streamlining others work to find optimal jobs. 

See the SQL queries here: [project_sql folder](https://github.com/simca273/SQL/blob/main/project_sql)

About the dataset: 

- It provides real-world information on data jobs market in 2023.
- It includes  insights on job titles, salaries, locations, essential skills, scheduled type or place of posting.

**The questions I wanted to answer through my SQL queries were:**

1. What are the top-paying data scientist jobs? 
2. What skills are required for data scientist top-paying jobs?
3. What skills are most in demand for data scientists?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

**Tools I Used**

For my dive into the data job market, I used several key tools:

- **SQL:** Allowing me to query the database and see critical insights.
- **PostgreSQL:** A database system that stores data and enables its efficient management.
- **Visual Studio Code:** I used this code editor for executing SQL queries.
- **Git & GitHub:** For sharing my project with others.


**The Analysis**

Each query of this project aimed at looking into specific aspects of the data scientist job market in order to understant its current trends. 

Here’s how I approached each question:

**1. Top Paying Data Scientist Jobs**

To identify the highest-paying roles, I filtered data scientist jobs by average yearly salary and location, focusing on remote jobs. 
This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
LIMIT 20
```

  Here's the breakdown of the top data scientist jobs in 2023:

- **Wide Salary Range:** The top 20 paying data scientist jobs move in the range $300,000 to 550,000. It shows that there is big range of salaries. It indicates significant salary potencial in this field.
- **Diverse Employers:** Companies like Sellby Jennings, Algo Capital Group, Demandbase or Reddit are among those offering high salaries. It shows interest in this role and its valuability across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Scientist to Director of Data Science, reflecting varied roles and specializations within data science.

![Dashboard](Images/Ds%20Jobs.png)

- **Excel Features:** Utilized bar chart feature (with formatted salary values) and optimized layout for clarity.
- **Design Choice:** Horizontal bar chart for visual comparison of median salaries.
- **Data Organization:** Sorted job titles by descending salary for improved readability.
- **Insights Gained:** This enables quick identification of salary trends, noting that senior data specialist roles belong between the highest-paid ones, as well as leadership roles. This highlights the importance of both technical skills and managerial responsibility in the field.


**2. Skills for Top Paying Jobs**

To understand what skills are required for the top-paying jobs, I joined the job postings table with the skills data.

```jsx
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
   salary_year_avg DESC;

```

Most demanded skills for the top 10 highest paying data scientist jobs in 2023:

- **Python** is leading with a bold count of 4.
- **SQL** follows closely with a count of 3.
- **Pytorch, Java Aws, Tensorflow** and **Spark** is also between more in demand skills, with a count of 2.

![Dashboard](Images/Ds%20Skills.png)

**In-demand skills for Data Scientists**

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```jsx
SELECT 
  skills,
    COUNT(skills_job_dim2.job_id) AS demand_count
FROM job_postings_fact2
INNER JOIN skills_job_dim2
    ON job_postings_fact2.job_id = skills_job_dim2.job_id
INNER JOIN skills_dim2
    ON skills_job_dim2.skill_id = skills_dim2.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5;
```

**Here's the breakdown of the most demanded skills for data scientists in 2023:**

- **Python** and **SQL** are fundamental skills for most data scientists. It emphase the need for strong ability to extract data from databases and automating and modeling the data.
- **Other programming languages** are also relevant, but R is less widely spread than Python.
- **Visualization Tools** like **Tableau** for vizualizing insights.
- **Cloud storage** **Cloud AWS** is important for storing large sets of data on cloud platform.

| Skill | Demand count |
| --- | --- |
| python | 10,390 |
| sql | 7,488 |
| r | 4,674 |
| aws | 2,593 |
| tableau | 2,458 |

*Table of the demand for the top 5 skills in data scientist job postings*

**4. Skills Based on Salary**

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```jsx
SELECT 
  skills,
  ROUND (AVG (salary_year_avg), 0) AS average_salary
FROM job_postings_fact2
INNER JOIN skills_job_dim2
    ON job_postings_fact2.job_id = skills_job_dim2.job_id
INNER JOIN skills_dim2
    ON skills_job_dim2.skill_id = skills_dim2.skill_id
WHERE
    job_title_short = 'Data Scientist' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    average_salary DESC
LIMIT 25;
```

**Here's a breakdown of the results for top paying skills for Data Scientists:**

- **Rules for using data:** Understanding GDPR is essential, especially in senior and managerial roles. Although it is not a technical tool, knowledge of data regulations makes it a valuable competency associated with higher-paying positions, where responsibility for knowledge of handeling data legally and ethically is critical.
- **Demand for Programming languages:** One of the top salaries are commanded by data scientists with expertise in Golang. This indicates an industry tendencies toward leveraging efficient programming languages, such as Go (Golang) and PHP for handling complex data processing tasks.
- **Demand for Cross-Platform Analytics Tools:** Tools such as Atlassian (Atlassian Analytics, Atlassian Data Lake) indicate a growing need to work with data from multiple systems in one place. This reflects industry trends toward integrating different tools and using dashboards to track performance and support decision-making.
- **Cloud Computing Expertise:** Familiarity with cloud tools such as (Neo4j, DynamoDB) underscores the growing importance of cloud-based analytics environments based on growing big data and suggesting that cloud proficiency significantly boosts earning potential.
- **Growth of automation:** The testing tool like Selenium and libraries (TidyVerse, OpenCV) used for data manipulation and OpenCV indicate the growing role of image and video data in advanced analytics and AI applications. Both show on the growth of shifting to automatization in data workflows and importance of working with these tools. These trends suggest a shift towards automation, integration of multiple data sources,


| Skill | Average salary ($) |
| --- | --- |
| gdpr | 217,738 |
| golang | 208,750 |
| atlassian | 189,700 |
| selenium | 180,000 |
| opencv | 172,500 |
| neo4j | 171,655 |
| microstrategy | 171,147 |
| dynamodb | 169,670 |
| php | 168,125 |
| tidyverse | 165,513 |

*Table of the average salary for the top 10 paying skills for data scientists*

**5. Most Optimal Skills to Learn**

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT
    skills_dim2.skill_id,
    skills_dim2.skills,
    COUNT(skills_job_dim2.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact2.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact2
INNER JOIN skills_job_dim2 ON job_postings_fact2.job_id = skills_job_dim2.job_id
INNER JOIN skills_dim2 ON skills_job_dim2.skill_id = skills_dim2.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim2.skill_id,
    skills_dim2.skills
HAVING
    COUNT(skills_job_dim2.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
Here's a breakdown of the most optimal skills for Data Scientists in 2023:


- **High-Demand Programming Language:** Python and its libraries strongly stand out for its high demand, with demand counts of 763. Its average salary is around $143,828, indicating that proficiency in Python is in data scientists roles widely used and valued.
- **Business Intelligence and Visualization Tools:** Tools such as Tableau, with a demand count of 219 and an average salary of approximately $146,970, highlight the importance of data visualization and business intelligence in transforming raw data into insights.
- **Cloud Technologies:** Cloud Technologies: Knowledge of platforms such as AWS and Snowflake shows strong demand, with average salaries comparable to those of knowing the core programming skills. This highlights the growing importance of cloud technologies for managing, storing, and processing large data.
- **Machine Learning Technologies:** TensorFlow and PyTorch are highly valuable frameworks in data science, with average salaries between $151,536 and $152,603. Their widely spread use in companies points at the growing demand and increasing value of artificial intelligence in business processes.

**What I Learned**

Throughout this project I enriched my SQL knowledge in:

- **Complex Query Crafting:**
-- Learned how to use intermediate SQL commands.

-- Extracted data from a PostgreSQL database using SQL in Visual Studio Code.
- **Data Aggregation:** Applied GROUP BY command in practical project and aggregate functions like COUNT() and AVG() into my data-summarizing.  
- **Combine Rows:** Combined data from multiple tables using SQL JOIN operations to answer questions where the required information was not available in a single table.
- **Analytical Skills:** Leveled up my analysis skills by turning questions into SQL queries based on which I executed insights for answering the specific questions.

**Key Insights**

From the analysis, several general insights emerged:

1. **Top-Paying Data Scientist Jobs**: The highest-paying remote jobs for data scientist offer a wide range of salaries, the highest at $550,000. The role can be found in various industries.
2. **Skills for Top-Paying Jobs**: High-paying data scientist jobs require advanced proficiency in Python and SQL, suggesting it’s a critical skill for earning a top salary. 
3. **Most In-Demand Skills**: Python and SQL are among the most in-demand skills in the data science job market. They are essential not only for high-paying roles but for positions across all levels, making them a key starting point for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as knowing GDPR, programming langages (Golang, PHP), Atlassian, Selenium are associated with the highest average salaries. Indicating a high apprechiation of understanding legal rules of working with data, working in cloud as of growing big data and orient itself in upto date automatization and cross tools.
5. **Optimal Skills for Job Market Value**: Python stands out as the most valuable skill, combining high demand with a strong average salary. This makes it a key skill for aspiring data scientists to learn in order to maximize their market value and enter the field.

**Closing Thoughts**

This project provided valuable insights into the data scientist job market. The findings can help aspiring data scientists understand the most valuable skills to learn for themselves. It can help them compare the difference between remote positions in situation they are deciding on the location type preferences. It is important to follow the trends as the data-related jobs market is constantly changing.
