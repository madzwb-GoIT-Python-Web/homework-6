--  Returns first student with highest average score by course
SELECT
    courses.name,
    students.id,
    students.first_name,
    students.last_name,
    ROUND(AVG(scores.score), 2) as score
FROM students
INNER JOIN scores ON students.id = scores.student_id
INNER JOIN courses  ON courses.id = scores.course_id
WHERE scores.course_id = 0
GROUP BY students.id, courses.name
ORDER BY score DESC
LIMIT 1
;

--  Returns all students with highest average score by course

DROP VIEW IF EXISTS students_averages_scores_by_courses;

CREATE VIEW students_averages_scores_by_courses AS
SELECT
    courses.id     AS course_id,
    courses.name   AS course_name,
    students.id     AS student_id,
    students.first_name,
    students.last_name,
    AVG(scores.score) OVER(PARTITION BY course_id, student_id) as average_score,
    -- AVG(scores.score) OVER(PARTITION BY course_id) as by_course_agverage_score,
    COUNT(*) OVER(PARTITION BY courses.id, students.id) as scores
FROM scores
INNER JOIN students ON scores.student_id = students.id
INNER JOIN courses ON scores.course_id = courses.id
ORDER BY course_id, average_score DESC
;

SELECT
    students_scores.course_name,
    students_scores.first_name,
    students_scores.last_name,
    ROUND(maximums.maximum_score, 2)
FROM students_averages_scores_by_courses AS students_scores
INNER JOIN
(
    SELECT
        course_id,
        course_name,
        MAX(average_score) as maximum_score
    FROM students_averages_scores_by_courses
    GROUP BY course_id, course_name
    ORDER BY course_id
) as maximums
ON  maximums.course_id     = students_scores.course_id
AND maximums.maximum_score  = students_scores.average_score
WHERE students_scores.course_id = 0
;
