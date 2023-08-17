CREATE VIEW students_averages_grades_by_subjects AS
SELECT
    subjects.id     AS subject_id,
    subjects.name   AS subject_name,
    students.id     AS student_id,
    students.first_name,
    students.last_name,
    AVG(dashboard.grade) OVER(PARTITION BY subject_id, student_id) as average_grade,
    -- AVG(dashboard.grade) OVER(PARTITION BY subject_id) as by_subject_agverage_grade,
    COUNT(*) OVER(PARTITION BY subjects.id, students.id) as grades
FROM dashboard
INNER JOIN students ON dashboard.student_id = students.id
INNER JOIN subjects ON dashboard.subject_id = subjects.id
ORDER BY subject_id, average_grade DESC
;
-- Get date of the last lesson by group

CREATE VIEW last_lessons_dates_by_groups
AS
    SELECT
        subjects.id as subject_id,
        -- subjects.name AS subject_name,
        groups.id AS group_id,
        -- groups.name AS group_name,
        MAX(CAST(dashboard.datetime AS DATE)) AS last_date
        -- groups.name AS group_name,
        -- students.id AS student_id,
        -- students.first_name AS student_first_name,
        -- students.last_name AS student_last_name
    FROM dashboard
    INNER JOIN subjects
    ON subjects.id = dashboard.subject_id
    INNER JOIN teachers
    ON teachers.id = subjects.teacher_id
    INNER JOIN students
    ON students.id = dashboard.student_id
    INNER JOIN groups
    ON groups.id = students.group_id
    -- WHERE CAST(dashboard.datetime AS DATE) = '2023-04-12'
    GROUP BY
        subjects.id,
        -- subjects.name,
        groups.id
        -- groups.name,
        -- dashboard.datetime
        -- students.id,
        -- students.first_name,
        -- students.last_name
    ORDER BY subjects.id, groups.id--, datetime DESC