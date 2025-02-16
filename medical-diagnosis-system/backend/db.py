import mysql.connector

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Minas@0202",
        database="medical_diagnosis"
    )
