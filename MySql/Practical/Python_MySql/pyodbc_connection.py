import pyodbc

SERVER = "SERVERNAME_HERE"  # localhost
DATABASE = "DATABASE_NAME_HERE"  # test_database
USERNAME = "USERNAME_HERE"  # user_name
PASSWORD = "PASSWORD_HERE"  # password
TABLENAME = "TABLE_NAME_HERE"  # test_table
# Driver_info can be obtained by using `pyodbc-installer -d -l` command in terminal.
cnxn = pyodbc.connect(
    "DRIVER={MySQL ODBC 8.0 Driver};SERVER="
    + SERVER
    + ";DATABASE="
    + DATABASE
    + ";UID="
    + USERNAME
    + ";PWD="
    + PASSWORD
)

cursor = cnxn.cursor()
cursor.execute(f"SELECT * FROM {TABLENAME}")

for i in cursor:
    print(i)
    exit()
