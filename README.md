# ETL Using Shell Scripts
Copy the data in the file 'web-server-access-log.txt.gz' to the table 'access_log' in the PostgreSQL database 'template1'.

The file is available at the location : Log Data

The following are the columns and their data types in the file:

a. timestamp - TIMESTAMP.
b. latitude - float.
c. longitude - float.
d. visitorid - char(37).

and two more columns: accessedfrommobile (boolean) and browser_code (int).

The columns which we need to copy to the table are the first four coumns : timestamp, latitude, longitude and visitorid.

NOTE: The file comes with a header. So use the 'HEADER' option in the 'COPY' command.
cp-access-log.sh.
This script downloads the file 'web-server-access-log.txt.gz' from Here

The script then extracts the .txt file using gunzip.

The .txt file contains the timestamp, latitude, longitude and visitor id apart from other data.

Transforms the text delimeter from "#" to "," and saves to a csv file.
Loads the data from the CSV file into the table 'access_log' in PostgreSQL database.

<img src="https://i.imgur.com/u82IcQO.jpg" width="900px" height=500px/>
