-- set to our schema
SET search_path to group17;

DROP TABLE IF EXISTS MentalHealthData;
CREATE TABLE IF NOT EXISTS MentalHealthData (
    id INT PRIMARY KEY,
    gender TEXT,
    age FLOAT,
    city TEXT,
    profession TEXT,
    academic_pressure FLOAT,
    work_pressure FLOAT,
    cgpa FLOAT,
    study_satisfaction FLOAT,
    job_satisfaction FLOAT,
    sleep_duration TEXT,
    dietary_habits TEXT,
    degree TEXT,
    suicidal_thoughts TEXT,
    work_study_hours FLOAT,
    financial_stress FLOAT,
    family_history TEXT,
    depression INT  -- Assuming 1 = yes, 0 = no
);

DROP TABLE IF EXISTS temp_mental_health_data;

CREATE TABLE temp_mental_health_data (
    id INT,
    gender TEXT,
    age FLOAT,
    city TEXT,
    profession TEXT,
    academic_pressure FLOAT,
    work_pressure FLOAT,
    cgpa FLOAT,
    study_satisfaction FLOAT,
    job_satisfaction FLOAT,
    sleep_duration TEXT,
    dietary_habits TEXT,
    degree TEXT,
    suicidal_thoughts TEXT,
    work_study_hours FLOAT,
    financial_stress FLOAT,
    family_history TEXT,
    depression INT
);


\COPY temp_mental_health_data FROM 'student_depression_dataset.csv' DELIMITER ',' CSV HEADER NULL '?';




INSERT INTO MentalHealthData
SELECT DISTINCT ON (id) *
FROM temp_mental_health_data
ORDER BY id;


-- Remove "Others" entry in sleep_duration since there's only 19 entries
DELETE FROM MentalHealthData
WHERE sleep_duration ='Others';


-- Cleaning by removing entries with '?'
ALTER TABLE MentalHealthData 
ADD CONSTRAINT check_no_entries_null
CHECK (financial_stress <> '?');

-- DROP TABLE IF EXISTS Student; 
-- CREATE TABLE IF NOT EXISTS Student(
--     id INT PRIMARY KEY,
--     gender TEXT,
--     age FLOAT,
--     city TEXT,
--     profession TEXT,
--     academic_pressure FLOAT,
--     work_pressure FLOAT,
--     cgpa FLOAT,


--     study_satisfaction FLOAT,
--     job_satisfaction FLOAT,
--     sleep_duration TEXT,
--     dietary_habits TEXT,
--     degree TEXT,
--     suicidal_thoughts TEXT,
--     work_study_hours FLOAT,
--     financial_stress FLOAT,
--     family_history TEXT,
--     depression INT
-- );

-- Try to find out how many categories for sleep_duration
SELECT sleep_duration, COUNT(*) AS count
FROM MentalHealthData
GROUP BY sleep_duration
ORDER BY sleep_duration;

-- INSERT INTO TABLE Student VALUES(
--     id,
--     gender,
--     age,
--     city,
--     profession,
--     academic_pressure,
--     work_pressure,
--     cgpa,
--     study_satisfaction,
--     job_satisfaction,
--     sleep_duration,
--     dietary_habits,
--     degree,
--     suicidal_thoughts,
--     work_study_hours,
--     financial_stress,
--     family_history,
--     depression
-- )
-- SELECT 
--     id,
--     gender,
--     age,
--     city,
--     profession,
--     academic_pressure,
--     work_pressure,
--     cgpa,
--     study_satisfaction,
--     job_satisfaction,
--     sleep_duration,
--     dietary_habits,
--     degree,
--     suicidal_thoughts,
--     work_study_hours,
--     financial_stress,
--     family_history,
--     depression

-- FROM MentalHealthData 
-- WHERE profession <> 'Student';

-- Determine if job satisfaction is all zero
SELECT DISTINCT job_satisfaction , COUNT(*) AS count 
FROM MentalHealthData
GROUP BY job_satisfaction
ORDER by count;

-- Not much difference (almost 100% of entries are zero)
-- DROP job_satisfaction FROM MentalHealthData;

-- Which top 10 cities has the highest depression rate
SELECT city, depression, COUNT(city) as depression_count
FROM MentalHealthData WHERE 
depression = 1
GROUP BY city, depression
ORDER BY depression_count DESC
LIMIT 10;