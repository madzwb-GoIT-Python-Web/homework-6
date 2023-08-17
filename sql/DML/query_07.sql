--  Returns scores of group by course.
SELECT
    groups.name,
    students.first_name,
    students.last_name,
    courses.name,
    scores.score,
    scores.datetime
FROM scores
INNER JOIN courses
ON courses.id = scores.course_id
INNER JOIN students
ON students.id = scores.student_id
INNER JOIN groups
ON students.group_id = groups.id
WHERE courses.id = 0 AND groups.id = 0
-- ORDER BY groups.id, students.id
;
