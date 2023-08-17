--  Returns average grade given by teacher for his subjects.
SELECT
    teachers.id,
    teachers.first_name,
    teachers.last_name,
    subjects.id AS subject_id,
    subjects.name,
    ROUND(AVG(dashboard.grade), 2)
FROM dashboard
INNER JOIN subjects
ON subjects.id = dashboard.subject_id
INNER JOIN teachers
ON teachers.id = subjects.teacher_id
WHERE teachers.id = 0
GROUP BY teachers.id, subjects.id
ORDER BY teachers.id, subjects.id
;
