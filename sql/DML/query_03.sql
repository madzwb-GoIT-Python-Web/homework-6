--  Returns average score in groups by courses.
SELECT
    groups.name,
    -- courses.id,
    courses.name,
    ROUND(AVG(scores.score), 2)
FROM scores
INNER JOIN courses
ON courses.id = scores.course_id
INNER JOIN students
ON students.id = scores.student_id
INNER JOIN groups
ON students.group_id = groups.id
-- WHERE courses.id = 0
GROUP BY
    groups.name,
    courses.id,
    courses.name
ORDER BY groups.name, courses.name
;