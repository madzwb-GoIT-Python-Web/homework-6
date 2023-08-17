--  Returns last lesson's grades for specific subject in specific group.
DROP VIEW IF EXISTS last_lessons_dates_by_groups;

CREATE VIEW last_lessons_dates_by_groups AS
    -- Get date of the last lesson by group
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
;

SELECT 
    dashboard.subject_id,
    subjects.name,
    students.group_id,
    groups.name,
    students.first_name,
    students.last_name,
    dashboard.grade,
    dashboard.datetime
FROM dashboard
INNER JOIN subjects
ON subjects.id = dashboard.subject_id
INNER JOIN students
ON students.id = dashboard.student_id
INNER JOIN groups
ON groups.id = students.group_id
INNER JOIN last_lessons_dates_by_groups as dates
ON
        dates.subject_id = dashboard.subject_id
    AND dates.group_id   = students.group_id
    AND dates.last_date  = CAST(dashboard.datetime AS DATE)
WHERE dashboard.subject_id = 0 AND students.group_id = 0
ORDER BY students.group_id, dashboard.subject_id
;
