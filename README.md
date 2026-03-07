**Introduction**

This  dataset focuses on data analyst roles and it´s job market. In this project I will answer questions such as top-paying jobs, demanded skills and where high demand meets high salary in data analytics. 
The goal was to  navigate the data analyst job market more effectively and find top-payed and in-demand skills, streamlining others work to find optimal jobs.

See the SQL queries here: [project_sql folder](https://github.com/lukebarousse/SQL_Project_Data_Job_Analysis/blob/main/project_sql)

Data come from: 

It includes  insights on job titles, salaries, locations, essential skills or scheduled type or place of posting.

**The questions I wanted to answer through my SQL queries were:**

1. What are the top-paying data analyst and scientist jobs? 
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts and scientists?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

**Tools I Used**

For my dive into the data analyst job market, I used several key tools:

- **SQL:** Allowing me to query the database and see critical insights.
- **PostgreSQL:** Database management system.
- **Visual Studio Code:** I used this code editor for executing SQL queries.
- **Git & GitHub:** For sharing my project with others.

**The Analysis**

Each query for this project aimed at looking into specific aspects of the data analyst and scientist job market in order to understant its current trends. Here’s how I approached each question:

**1. Top Paying Data Analyst Jobs**

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

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
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 20
```

Here's the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** The top 20 paying data scientist jobs move in the range $300,000 to 550,000. In companison with data analyst roles it shows that there is bigger range of salaries for data analysts with a bigger (strop) top 1 salary. It indicates significant salary potencial in this field?
- **Diverse Employers:** Companies like Sellby Jennings, Algo Capital Group, Demandbase or Reddit are among those offering high salaries. It shows interest in this role and its valuability across different industries.
- **Job Title Variety:** *There's a high diversity in job titles, from Data Scientist to Director of Data Science, reflecting varied roles and specializations within data science.*

![image.png](attachment:6ccec41b-a48e-439d-893e-8815da2d5798:image.png)

- **Insights Gained:** This enables quick identification of salary trends, noting that Data Scientists are higher payed that directors.?

Here's the breakdown of the top data analyst jobs in 2023:

- **Wide Salary Range:** The top 10 paying data analyst jobs move in the range 184,000 to 650,000. In companison with data analyst roles it shows that there is bigger range of salaries for data analysts with a bigger (strop) top 1 salary. It indicates significant salary potencial in this field?
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T, Uber are among those offering high salaries. It shows interest in this role and its valuability across different industries.
- **Job Title Variety:** *There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting various specializations within data analytics.*

Average Salary for Top 10 Paying Data Analyst Jobs in 2023.

Low Sample and range: In Germany there is 90,931 - 171,121 for Data Scientists. It shows on low sample in the dataset, which can drew the results.

Lower Salary Potential: Yet there is clear pattern that remote jobs have higher salary potential.

Diverse Employers: Between the companies show up famous German companies with 

Low Sample and **Wide Salary Range**: In Germany there is 56,381- 179,500 for Data Analysts. It shows on low sample in the dataset, which can drew the results. 

Lower Salary Potential: There is clear pattern that remote jobs for data analyst have higher salary potential.

Diverse Employers: Companies like [**Fraunhofer-Gesellschaft](https://www.fraunhofer.de/), Schwarz Gruppe (Lidl, Kaufland) or U.S. Army Command.** Between the companies show up big German companies, as well as state employer?.

![image.png](attachment:f96b07f5-2c5a-4713-b198-c2789f1dd674:image.png)

- **Excel Features:** Utilized bar chart feature (with formatted salary values) and optimized layout for clarity.
- **Design Choice:** Horizontal bar chart for visual comparison of median salaries.
- **Data Organization:** Sorted job titles by descending salary for improved readability.
- **Insights Gained:** **This enables quick identification of salary trends, noting that Director roles and Engineers are higher-paying than Analyst roles.**

| Job Title | Salary (Yearly USD) | Company |
| --- | --- | --- |
| Data Analyst | 650,000 | Mantys |
| Director of Analytics | 336,500 | Meta |
| Associate Director- Data Insights | 255,829.5 | AT&T |
| Data Analyst, Marketing | 232,423 | Pinterest Job Advertisements |
| Data Analyst (Hybrid/Remote) | 217,000 | Uclahealthcareers |

**2. Skills for Top Paying Jobs**

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, which  skills employers apprechiate the most.

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
   salary_year_avg DESC;

```

Most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- **SQL** is leading with a bold count of 10.
- **Python** follows closely with a bold count of 10.
- **Tableau** is also highly demanded, with a bold count of 7. Other skills like **R** and **Excel** are often required by employeer on high paying data analyst positions.

![image.png](attachment:2a14ca25-7c78-445b-ba86-c3f5b8dd2a09:image.png)

Most demanded skills for the top 10 highest paying data scientist jobs in 2023:

- Python is leading with a bold count of 4.
- SQL follows closely with a bold count of 3.
- **Pytorch, Java Aws, Tensorflow and Spark** is also between more in demand skills, with a count of 2.
- Comparison: Unlike Data Analyst jobs, Data Scientist have higher diversity and lower universality of skills. Data Scientist in different companies/sectors are more likely need different set of skills. They need to speciality more in their position. Also showcasing higher importance of programming languages.

![image.png](attachment:6d333ea8-e709-41bc-8c5b-38e37d561f68:image.png)

**3. In-Demand Skills for Data Analysts**

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
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5;
```

Here's the breakdown of the most demanded skills for data analysts in 2023

- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills and automatization in data storytelling and decision support.

| **Skills** | **Demand Count** |
| --- | --- |
| SQL | 7291 |
| Excel | 4611 |
| Python | 4330 |
| Tableau | 3745 |
| Power BI | 2609 |

*Table of the demand for the top 5 skills in data analyst job postings*

Here's the breakdown of the most demanded skills for data scientists in 2023:

- Python and SQL are fundamental skills for most data scientists. It emphase the need for strong ability to extract data from databases and automating and modeling the data.
- **Other programming** languages are also relevant, but R is less widely spread.
- **Visualization Tools** like **Tableau for vizualizing insights and Cloud AWS are also important for storing large sets of data on cloud platform.**

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
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    average_salary DESC
LIMIT 25;
```

Here's a breakdown of the results for top paying skills for Data Analysts:

- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a crossover between data analysis and engineering, that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| **Skills** | **Average Salary ($)** |
| --- | --- |
| pyspark | 208,172 |
| bitbucket | 189,155 |
| couchbase | 160,515 |
| watson | 160,515 |
| datarobot | 155,486 |
| gitlab | 154,500 |
| swift | 153,750 |
| jupyter | 152,777 |
| pandas | 151,821 |
| elasticsearch | 145,000 |

*Table of the average salary for the top 10 paying skills for data analysts*

Here's a breakdown of the results for top paying skills for Data Scientists:

- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies (PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a crossover between data analysis and engineering, that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

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
    job_title_short = 'Data Analyst'
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

| **Skill ID** | **Skills** | **Demand Count** | **Average Salary ($)** |
| --- | --- | --- | --- |
| 8 | go | 27 | 115,320 |
| 234 | confluence | 11 | 114,210 |
| 97 | hadoop | 22 | 113,193 |
| 80 | snowflake | 37 | 112,948 |
| 74 | azure | 34 | 111,225 |
| 77 | bigquery | 13 | 109,654 |
| 76 | aws | 32 | 108,317 |
| 4 | java | 17 | 106,906 |
| 194 | ssis | 12 | 106,683 |
| 233 | jira | 20 | 104,918 |

*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023:

- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

*Table of the most optimal skills for data scientists sorted by salary:*

| Skill | Demand count | Avg salary ($) |
| --- | --- | --- |
| python | 763 | 143,828 |
| tableau | 219 | 146,970 |
| aws | 217 | 149,630 |
| spark | 149 | 150,188 |
| tensorflow | 126 | 151,536 |
| pytorch | 115 | 152,603 |
| pandas | 113 | 144,816 |
| scikit-learn | 81 | 148,964 |
| snowflake | 72 | 152,687 |
| numpy | 73 | 149,089 |

Here's a breakdown of the most optimal skills for Data Scientists in 2023:

- **High-Demand Programming Languages:** Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
- **Cloud Tools and Technologies:** Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
- **Business Intelligence and Visualization Tools:** Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
- **Database Technologies:** The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

**What I Learned**

Throughout this project I enriched my  SQL knowledge in:

- **Complex Query Crafting:**
- Learned how to use basic up to intermediate sql commands.
- Extract data from PostGres database, connect it to VS Code and with SQL comands.
- **Data Aggregation:** Got to use GROUP BY command in practical project and get more comfatable with using it and aggregate functions like COUNT() and AVG() into my data-summarizing.
- Combine Rows: Included combining data from two different tables to answer questions for which the necesary info wasnt in one table by using JOINs.
- **Analytical Skills:** Leveled up my analysis skills by turning questions into SQL queries based on which I executed insights for answering the specific questions.

**Conclusions**

**Insights**

From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

**Closing Thoughts**

This project provided valuable insights into the data analyst and data scientist job market. The findings can help aspiring data analyst and scientists understand the most valuable skills to learn for themselves. It can help them compare the difference between remote positions and European in situation they are deciding on the location type preferences. It is important to follow the trends as the data-related jobs market is constantly changing.
