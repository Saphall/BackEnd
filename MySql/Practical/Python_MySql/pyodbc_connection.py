import pyodbc
server='SERVERNAME_HERE'
database= 'DATABASE_NAME_HERE'
username='USERNAME_HERE'
password='PASSWORD_HERE'
cnxn=pyodbc.connect('DRIVER={MySQL};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)

cursor = cnxn.cursor()
