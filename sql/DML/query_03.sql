--  Returns average grade in groups by subjects.
SELECT
    groups.name,
    -- subjects.id,
    subjects.name,
    ROUND(AVG(dashboard.grade), 2)
FROM dashboard
INNER JOIN subjects
ON subjects.id = dashboard.subject_id
INNER JOIN students
ON students.id = dashboard.student_id
INNER JOIN groups
ON students.group_id = groups.id
-- WHERE subjects.id = 0
GROUP BY
    groups.name,
    subjects.id,
    subjects.name
ORDER BY groups.name, subjects.name
;