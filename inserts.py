import datetime
import calendar
import faker
import pathlib
import psycopg2
import random
import tabulate

X = "%s"#?

def groups(faker, groups):

    datas = []
    sql = f"INSERT INTO groups(id, name) VALUES ({X}, {X})"
    for id, name in enumerate(groups):
        group = (id, name)
        datas.append(group)
    return datas, sql

def students(faker, number, groups):
    datas = []
    sql = f"INSERT INTO students(id, first_name, last_name, group_id) VALUES ({X}, {X}, {X}, (SELECT id FROM groups WHERE name = {X}))"
    for id in range(number):
        group_id = random.randint(0, len(groups) - 1)
        group = random.choice(groups)
        student = (id, faker.first_name(), faker.last_name(), group[1])#group_id)
        datas.append(student)
    return datas, sql

def teachers(faker, number):
    datas = []
    # list_datas = []
    sql = f"INSERT INTO teachers(id, first_name, last_name) VALUES ({X}, {X}, {X})"
    for id in range(number):
        first_name = faker.first_name()
        last_name = faker.last_name()
        # list_datas.append(first_name + " " + last_name)
        teacher = (id, first_name, last_name)
        datas.append(teacher)
    return datas, sql#, list_datas

def subjects(faker, subjects, teachers):
    datas = []
    sql = f"INSERT INTO subjects(id, name, teacher_id) VALUES ({X}, {X}, {X})"
    for id, name in enumerate(subjects):
        subject = (id,name, random.choice(teachers)[0])
        datas.append(subject)
    return datas, sql

def dashboard(faker, max_grades, subjects, students):
    datas = []
    sql = f"INSERT INTO dashboard(id, subject_id, student_id, datetime, grade) VALUES ({X}, {X}, {X}, {X}, {X})"
    _calendar = calendar.Calendar(calendar.MONDAY)
    id = 0
    for _ in range(0, max_grades):
        for student in students:
            year    = 2023
            month   = random.randint(1,12)
            days    = []
            for date in _calendar.itermonthdates(year, month):
                if date.month == month and date.weekday() < 5:
                    days.append(date.day)
            # days = calendar.monthrange(year, month)[1]
            subject = random.choices(subjects)
            timestamp = datetime.datetime(
                            year,
                            month,
                            random.choice(days),
                            random.randint(9, 21),
                            random.randint(1, 59),
                            random.randint(1, 59)
                        )
            rate = (id, random.choices(subjects)[0][0], student[0], timestamp.isoformat(), random.randint(1, 12))
            datas.append(rate)
            id += 1
    return datas, sql

def fill_db(cursor):
    max_students    = 50
    max_teachers    = 5
    max_subjects    = 8
    max_grades      = 20

    _groups = ["A", "B", "C"]
    _subjects = [
        "Introduction to Computer Science",
        "Data Structures and Algorithms",
        "Computer Systems Engineering",
        "Introduction to Artificial Intelligence",
        "Operating Systems",
        "Database Management Systems",
        "Software Engineering",
        "Computer Networks",
        "Computer Graphics",
        "Theory of Computation",
        "Machine Learning",
        "Human-Computer Interaction",
        "Computer Security and Cryptography",
        "Distributed Systems",
        "Web Development",
        "Natural Language Processing",
        "Robotics",
        "Computational Biology",
        "Compiler Design",
        "Parallel Computing"
    ]
    _faker = faker.Faker()
    groups_datas    , groups_sql    = groups    (_faker, _groups)
    students_datas  , students_sql  = students  (_faker, max_students, groups_datas)
    teachers_datas  , teachers_sql  = teachers  (_faker, max_teachers)
    subjects_datas  , subjects_sql  = subjects  (_faker, _subjects, teachers_datas)
    dashboard_datas , dashboard_sql = dashboard (_faker, max_grades, subjects_datas, students_datas)
    cursor.executemany(groups_sql   , groups_datas)
    cursor.executemany(students_sql , students_datas)
    cursor.executemany(teachers_sql , teachers_datas)
    cursor.executemany(subjects_sql , subjects_datas)
    cursor.executemany(dashboard_sql, dashboard_datas)
    

def main():

    conection = psycopg2.connect(
                    database    ="postgres",
                    user        ="postgres",
                    password    ="postgres",
                    host        ="localhost",
                    port        ="5432"
                )
    cursor = conection.cursor()
    try:
        open(".lock","r")
    except Exception as e:
        fill_db(cursor)
        conection.commit()
        open(".lock","rw")

    for path in pathlib.Path.cwd().joinpath("sql/DML").iterdir():
        with open(path,"r") as fd:
            sql = fd.read()
            cursor.execute(sql)
            rows = cursor.fetchall()
            # Some parts of this code(below the comment) was writen with helps of CPT-3.5.
            # headers=[i[0] for i in cursor.description]
            print(tabulate.tabulate(rows, headers=[i[0] for i in cursor.description]))
    pass

if __name__ == "__main__":
    main()
