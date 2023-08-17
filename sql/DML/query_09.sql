--  Returns courses attended by the student.
SELECT
    students.id,
    students.first_name,
    students.last_name,
    courses.id,
    courses.name
FROM students
INNER JOIN scores
ON scores.student_id = students.id
INNER JOIN courses
ON courses.id = scores.course_id
WHERE students.id = 0
GROUP BY
    students.id,
    students.first_name,
    students.last_name,
    courses.id,
    courses.name
ORDER BY students.id, courses.id
;
