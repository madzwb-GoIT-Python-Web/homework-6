import pathlib
import psycopg2
import tabulate

import inserts

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
        for path in pathlib.Path.cwd().joinpath("sql/DDL").iterdir():
            with open(path.joinpath("create.sql")) as fd:
                if sql := fd.read():
                    cursor.execute(sql)
        else:
            conection.commit()
        inserts.fill_db(cursor)
        conection.commit()
        open(".lock","w")

    for path in pathlib.Path.cwd().joinpath("sql/DML").iterdir():
        with open(path,"r") as fd:
            if sql := fd.read():
                fd.seek(0)
                comment = fd.readline()
                cursor.execute(sql)
                rows = cursor.fetchall()
                # Some parts of this code(below the comment) was writen with helps of CPT-3.5.
                # headers=[i[0] for i in cursor.description]
                print(path.name + " " + comment)
                print(tabulate.tabulate(rows, headers=[i[0] for i in cursor.description]))
    pass

if __name__ == "__main__":
    main()
