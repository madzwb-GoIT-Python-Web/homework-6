--  Returns courses attended by the student.
SELECT
    students.id,
    students.first_name,
    students.last_name,
    subjects.id,
    subjects.name
FROM students
INNER JOIN dashboard
ON dashboard.student_id = students.id
INNER JOIN subjects
ON subjects.id = dashboard.subject_id
WHERE students.id = 0
GROUP BY
    students.id,
    students.first_name,
    students.last_name,
    subjects.id,
    subjects.name
ORDER BY students.id, subjects.id
;
