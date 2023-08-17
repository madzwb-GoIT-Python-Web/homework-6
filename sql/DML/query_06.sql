--  Returns students in the group.
SELECT
    groups.name,
    students.first_name,
    students.last_name
FROM students
INNER JOIN groups
ON groups.id = students.group_id
WHERE groups.id = 0
-- ORDER BY students.group_id, students.id
;
