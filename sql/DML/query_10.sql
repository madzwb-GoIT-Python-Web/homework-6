--  Returns courses that teacher reads to student.
SELECT
    students.id,
    students.first_name,
    students.last_name,
    courses.name,
    teachers.id AS teacher_id,
    teachers.first_name AS teacher_first_name,
    teachers.last_name AS teacher_last_name
FROM students
INNER JOIN scores
ON scores.student_id = students.id
INNER JOIN courses
ON courses.id = scores.course_id
INNER JOIN teachers
ON teachers.id = courses.teacher_id
WHERE students.id = 0 AND teachers.id = 0
GROUP BY 
    students.id,
    students.first_name,
    students.last_name,
    courses.id,
    courses.name,
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
    courses.id
    -- courses.name,
;
