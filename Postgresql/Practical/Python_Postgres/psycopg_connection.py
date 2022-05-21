import psycopg2

try:
    connection = psycopg2.connect(
        user="USERNAME_HERE",  # user_name
        password="PASSWORD_HERE",  # password
        host="HOST_HERE",  # localhost
        port="PORT_HERE",  # 5432
        database="DATABASE_HERE",  # test_database
    )
    cursor = connection.cursor()

    table_create_query = """
    CREATE TABLE IF NOT EXISTS test(
        id serial PRIMARY KEY,
        first_name VARCHAR(30) NOT NULL,
        last_name VARCHAR(30) NOT NULL,
        dob DATE,
        location VARCHAR(50),
    );"""

    cursor.execute(table_create_query)
    connection.commit()

except Exception as e:
    print("[-] Exception Occurred:", e)

finally:
    print("[+] Executed !")
    cursor.close()
    connection.close()
    print("[+] Connection Closed !")
