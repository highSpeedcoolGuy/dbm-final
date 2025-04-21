-- set to our schema
SET search_path to group17;

CREATE TABLE mental_health_data (
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


\COPY mental_health_data FROM 'student_depression_data.csv' DELIMITER ',' CSV HEADER;
