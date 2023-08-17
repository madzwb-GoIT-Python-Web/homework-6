SELECT
    teachers.id AS teacher_id,
    teachers.first_name AS teacher_first_name,
    teachers.last_name AS teacher_last_name,
    students.id AS student_id,
    students.first_name AS student_first_name,
    students.last_name AS student_last_name,
    ROUND(AVG(dashboard.grade), 2),
    COUNT(*)
FROM dashboard
INNER JOIN subjects
ON subjects.id = dashboard.subject_id
INNER JOIN teachers
ON teachers.id = subjects.teacher_id
INNER JOIN students
ON students.id = dashboard.student_id
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
