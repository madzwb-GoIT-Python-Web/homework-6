--  Returns first student with highest average grade by subject
SELECT
    subjects.name,
    students.id,
    students.first_name,
    students.last_name,
    ROUND(AVG(dashboard.grade), 2) as grade
FROM students
INNER JOIN dashboard ON students.id = dashboard.student_id
INNER JOIN subjects  ON subjects.id = dashboard.subject_id
WHERE dashboard.subject_id = 0
GROUP BY students.id, subjects.name
ORDER BY grade DESC
LIMIT 1
;

--  Returns all students with highest average grade by subject

DROP VIEW IF EXISTS students_averages_grades_by_subjects;

CREATE VIEW students_averages_grades_by_subjects AS
SELECT
    subjects.id     AS subject_id,
    subjects.name   AS subject_name,
    students.id     AS student_id,
    students.first_name,
    students.last_name,
    AVG(dashboard.grade) OVER(PARTITION BY subject_id, student_id) as average_grade,
    -- AVG(dashboard.grade) OVER(PARTITION BY subject_id) as by_subject_agverage_grade,
    COUNT(*) OVER(PARTITION BY subjects.id, students.id) as grades
FROM dashboard
INNER JOIN students ON dashboard.student_id = students.id
INNER JOIN subjects ON dashboard.subject_id = subjects.id
ORDER BY subject_id, average_grade DESC
;

SELECT
    students_grades.subject_name,
    students_grades.first_name,
    students_grades.last_name,
    ROUND(maximums.maximum_grade, 2)
FROM students_averages_grades_by_subjects AS students_grades
INNER JOIN
(
    SELECT
        subject_id,
        subject_name,
        MAX(average_grade) as maximum_grade
    FROM students_averages_grades_by_subjects
    GROUP BY subject_id, subject_name
    ORDER BY subject_id
) as maximums
ON  maximums.subject_id     = students_grades.subject_id
AND maximums.maximum_grade  = students_grades.average_grade
WHERE students_grades.subject_id = 0
;
