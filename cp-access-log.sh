#! /bin/bash

# Practice Exercise 'ETL and Data Pipelines with Shell, Airflow and Kafka'

# cp-access-log.sh

# This script downloads the file 'web-server-access-log.txt.gz'
# from "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz".

# The following are the columns and their data types in the file:

# a. timestamp - TIMESTAMP

# b. latitude - float

# c. longitude - float

# d. visitorid - char(37)

# and two more columns: accessed_from_mobile (boolean) and browser_code (int)

# The columns which we need to copy to the table are the first four coumns : timestamp, latitude, longitude and visitorid.

# The script then extracts the .txt file using gunzip.

# The .txt file contains the timestamp, latitude, longitude 
# and visitor id apart from other data.

# Transforms the text delimeter from "#" to "," and saves to a csv file.
# Loads the data from the CSV file into the table 'access_log' in PostgreSQL database.

# Start database service: sudo service postgresql start  
# Login to Database:  psql --username=postgres --host=localhost
# List Databases: \l
# Connect to Databse: \c template1

# Creating Table
echo "Creating access_log table in PostgreSQL database"

echo '\c template1;\\CREATE TABLE IF NOT EXISTS access_log(timestamp TIMESTAMP, latitude float, longitude float, visitor_id char(37));' | psql --username=postgres --host=localhost

# Downloading File
echo "Downloading the file"
wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

# Unzip
echo "Unzip the .gz file"

gunzip  web-server-access-log.txt.gz --assume-yes

# Extract
echo "Extracting required fields"

cut -d"#" -f1-4 web-server-access-log.txt > extracted-data.txt

# Transform
echo "Transforming Data into CSV format"

tr "#" "," < extracted-data.txt > extracted-data.csv

# Load
echo "Loading data into the table access_log in PostgreSQL"

echo "\c template1;\COPY access_log FROM '/home/maz/Course_8_ETL_and_Data_Pipelines_with_Shell_Airflow_Kafka/extracted-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost 

# Check or Verify database
echo "Verifing by querying the database"

echo '\c template1; \\SELECT * from access_log;' | psql --username=postgres --host=localhost

echo "ETL with Shell Completed"