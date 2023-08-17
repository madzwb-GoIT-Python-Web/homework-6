CREATE VIEW students_averages_scores_by_courses AS
SELECT
    courses.id     AS course_id,
    courses.name   AS course_name,
    students.id     AS student_id,
    students.first_name,
    students.last_name,
    AVG(scores.score) OVER(PARTITION BY course_id, student_id) as average_score,
    -- AVG(scores.score) OVER(PARTITION BY course_id) as by_course_agverage_score,
    COUNT(*) OVER(PARTITION BY courses.id, students.id) as scores
FROM scores
INNER JOIN students ON scores.student_id = students.id
INNER JOIN courses ON scores.course_id = courses.id
ORDER BY course_id, average_score DESC
;
-- Get date of the last lesson by group

CREATE VIEW last_lessons_dates_by_groups
AS
    SELECT
        courses.id as course_id,
        -- courses.name AS course_name,
        groups.id AS group_id,
        -- groups.name AS group_name,
        MAX(CAST(scores.datetime AS DATE)) AS last_date
        -- groups.name AS group_name,
        -- students.id AS student_id,
        -- students.first_name AS student_first_name,
        -- students.last_name AS student_last_name
    FROM scores
    INNER JOIN courses
    ON courses.id = scores.course_id
    INNER JOIN teachers
    ON teachers.id = courses.teacher_id
    INNER JOIN students
    ON students.id = scores.student_id
    INNER JOIN groups
    ON groups.id = students.group_id
    -- WHERE CAST(scores.datetime AS DATE) = '2023-04-12'
    GROUP BY
        courses.id,
        -- courses.name,
        groups.id
        -- groups.name,
        -- scores.datetime
        -- students.id,
        -- students.first_name,
        -- students.last_name
    ORDER BY courses.id, groups.id--, datetime DESC