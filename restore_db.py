import os
import psycopg2
from urllib.parse import urlparse

# Set up environment variables
os.environ['DATABASE_URL'] = 'postgresql://postgres:REo88YlpaTkgMWxw@usojunbxhshqqixpuerm.supabase.co:5432/future-flower-shop'

# Parse the DATABASE_URL to extract connection parameters
url = urlparse(os.environ['DATABASE_URL'])
hostname = url.hostname
port = url.port
username = url.username
password = url.password
database = url.path[1:]

# Initialize connection variable
connection = None

# Establish a connection to the Supabase database
try:
    connection = psycopg2.connect(
        host=hostname,
        port=port,
        user=username,
        password=password,
        database=database
    )
    cursor = connection.cursor()

    # Read the SQL dump file
    with open('dump.sql', 'r') as file:
        sql = file.read()

    # Execute the SQL commands
    cursor.execute(sql)
    connection.commit()

    print("Database restored successfully.")

except Exception as e:
    print(f"An error occurred: {e}")

finally:
    if connection:
        cursor.close()
        connection.close()
