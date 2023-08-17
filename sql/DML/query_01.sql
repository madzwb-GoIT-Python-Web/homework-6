--  Returns first five studens with highest average score.
SELECT
    students.id,
    students.first_name,
    students.last_name,
    ROUND(AVG(scores.score), 2) as score
FROM students
INNER JOIN scores ON students.id = scores.student_id
GROUP BY students.id
ORDER BY score DESC
LIMIT 5
;
