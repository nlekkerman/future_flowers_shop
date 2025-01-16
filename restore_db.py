import os
import subprocess
from urllib.parse import urlparse

# Set up environment variable for the database URL
os.environ['DATABASE_URL'] = 'postgres://postgres.nukvcfrfdhthnewjewbl:T1LoObo8Zkq6Jbon@aws-0-eu-west-1.pooler.supabase.com:5432/postgres?sslmode=require'

# Parse the DATABASE_URL to extract connection parameters
url = urlparse(os.environ['DATABASE_URL'])
hostname = url.hostname
port = url.port
username = url.username
password = url.password
database = url.path[1:]

# Set the command for psql restore
psql_command = f"psql -h {hostname} -p {port} -U {username} -d {database} -f /workspace/future_flowers_shop/dump.sql"

# Use subprocess to call psql and restore the database
try:
    subprocess.run(psql_command, shell=True, check=True)
    print("Database restored successfully.")
except subprocess.CalledProcessError as e:
    print(f"An error occurred: {e}")
