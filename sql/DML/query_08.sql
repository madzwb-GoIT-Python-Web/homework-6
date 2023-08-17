--  Returns average score given by teacher for his courses.
SELECT
    teachers.id,
    teachers.first_name,
    teachers.last_name,
    courses.id AS course_id,
    courses.name,
    ROUND(AVG(scores.score), 2)
FROM scores
INNER JOIN courses
ON courses.id = scores.course_id
INNER JOIN teachers
ON teachers.id = courses.teacher_id
WHERE teachers.id = 0
GROUP BY teachers.id, courses.id
ORDER BY teachers.id, courses.id
;
