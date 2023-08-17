--  Returns subjects taught by the teacher.
SELECT
    teachers.id,
    teachers.first_name,
    teachers.last_name,
    subjects.name
FROM teachers
INNER JOIN subjects
ON subjects.teacher_id = teachers.id
WHERE teachers.id = 0
-- ORDER BY teachers.id
;
