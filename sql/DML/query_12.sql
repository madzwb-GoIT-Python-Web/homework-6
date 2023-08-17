--  Returns last lesson's scores for specific course in specific group.
DROP VIEW IF EXISTS last_lessons_dates_by_groups;

CREATE VIEW last_lessons_dates_by_groups AS
    -- Get date of the last lesson by group
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
;

SELECT 
    scores.course_id,
    courses.name,
    students.group_id,
    groups.name,
    students.first_name,
    students.last_name,
    scores.score,
    scores.datetime
FROM scores
INNER JOIN courses
ON courses.id = scores.course_id
INNER JOIN students
ON students.id = scores.student_id
INNER JOIN groups
ON groups.id = students.group_id
INNER JOIN last_lessons_dates_by_groups as dates
ON
        dates.course_id = scores.course_id
    AND dates.group_id   = students.group_id
    AND dates.last_date  = CAST(scores.datetime AS DATE)
WHERE scores.course_id = 0 AND students.group_id = 0
ORDER BY students.group_id, scores.course_id
;
