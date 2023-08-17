--  Returns average score given by a particular teacher to a particular student.
SELECT
    teachers.id AS teacher_id,
    teachers.first_name AS teacher_first_name,
    teachers.last_name AS teacher_last_name,
    students.id AS student_id,
    students.first_name AS student_first_name,
    students.last_name AS student_last_name,
    ROUND(AVG(scores.score), 2),
    COUNT(*)
FROM scores
INNER JOIN courses
ON courses.id = scores.course_id
INNER JOIN teachers
ON teachers.id = courses.teacher_id
INNER JOIN students
ON students.id = scores.student_id
WHERE teachers.id = 0 AND students.id = 0
GROUP BY 
    teachers.id,
    teachers.first_name,
    teachers.last_name,
    students.id,
    students.first_name,
    students.last_name
-- HAVING teachers.id = 0 AND students.id = 0
ORDER BY teachers.id, students.id
;
