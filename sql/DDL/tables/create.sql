CREATE TABLE groups(
    id INT PRIMARY KEY,
    name VARCHAR(128) UNIQUE
);

CREATE TABLE students(
    id INT PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL,
    -- middle_name VARCHAR(128),
    group_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES groups (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE teachers(
    id INT PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128) NOT NULL
    -- middle_name VARCHAR(128)
);

CREATE TABLE courses(
    id INT PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    teacher_id INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE scores(
    id INT PRIMARY KEY,
    course_id INT NOT NULL,
    student_id INT NOT NULL,
    datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    score INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
