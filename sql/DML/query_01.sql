--  Returns first five studens with highest average grade.
SELECT
    students.id,
    students.first_name,
    students.last_name,
    ROUND(AVG(dashboard.grade), 2) as grade
FROM students
INNER JOIN dashboard ON students.id = dashboard.student_id
GROUP BY students.id
ORDER BY grade DESC
LIMIT 5
;
