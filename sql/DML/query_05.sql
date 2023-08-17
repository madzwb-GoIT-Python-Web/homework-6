--  Returns courses taught by the teacher.
SELECT
    teachers.id,
    teachers.first_name,
    teachers.last_name,
    courses.name
FROM teachers
INNER JOIN courses
ON courses.teacher_id = teachers.id
WHERE teachers.id = 0
-- ORDER BY teachers.id
;
