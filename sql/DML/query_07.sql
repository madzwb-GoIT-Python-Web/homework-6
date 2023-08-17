SELECT
    groups.name,
    students.first_name,
    students.last_name,
    subjects.name,
    dashboard.grade,
    dashboard.datetime
FROM dashboard
INNER JOIN subjects
ON subjects.id = dashboard.subject_id
INNER JOIN students
ON students.id = dashboard.student_id
INNER JOIN groups
ON students.group_id = groups.id
WHERE subjects.id = 0 AND groups.id = 0
-- ORDER BY groups.id, students.id
;
