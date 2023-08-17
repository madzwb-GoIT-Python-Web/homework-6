--  Returns courses that teacher reads to student.
SELECT
    students.id,
    students.first_name,
    students.last_name,
    subjects.name,
    teachers.id AS teacher_id,
    teachers.first_name AS teacher_first_name,
    teachers.last_name AS teacher_last_name
FROM students
INNER JOIN dashboard
ON dashboard.student_id = students.id
INNER JOIN subjects
ON subjects.id = dashboard.subject_id
INNER JOIN teachers
ON teachers.id = subjects.teacher_id
WHERE students.id = 0 AND teachers.id = 0
GROUP BY 
    students.id,
    students.first_name,
    students.last_name,
    subjects.id,
    subjects.name,
    teachers.id,
    teachers.first_name,
    teachers.last_name
-- HAVING students.id = 0 AND teachers.id = 0
ORDER BY
    students.id,
    -- students.first_name,
    -- students.last_name,
    teachers.id,
    -- teachers.first_name,
    -- teachers.last_name
    subjects.id
    -- subjects.name,
;
