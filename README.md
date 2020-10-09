# Apache-AirFlow


1) "AIRFLOW_DAG_FILES.DAG" -- File contains all the work flow of the STAR WARS API data import process using Apache Airflow .

       i) Step1: "ExtractJSON_FROM_STARWARS_API.py" - python file will extract the json data from Star Wars API and save the json data into "STAR_WARS_API.json" file.
      ii) Step2: Created "AIRFLOW_IMPORT_JSON_QUERY.SQL" file which contains the create table query and import the json data into a structured table
and also the results will be ordered by character age while inserting into the final table.
     iii) Step3: For executing the SQL Command through DAG, we have created the Shell and python script. "IMPORT_DATA.BAT" -- file which contains the SQL server credentials, SQL query file( AIRFLOW_IMPORT_JSON_QUERY.SQL) path and log file(Import_Log.txt) path.
                      a) SQL query file contains the create table and import data query
                      b) "Import_Log.txt " file contains the query execution results to identify the status.
     iv) The above mentioned BAT will execute based on the STEP1 json data extraction completion in DAG. I have mentioned the two possible ways to execute task2 (import data to DB server).
     v) This "IMPORT_DATA.BAT" file execution scripts added into "STARWARS_API_Imports_DATA.py" file and this task added into Airflow DAG.
    vi) I am not having the proper setup for Apache Airflow tasks. So, I have shared the DAG flows in the "AIRFLOW_DAG_FILES.DAG" file.

Please find the attached zip folder which contains all the scripts based on the above request.

Note: Before executing the DAG script we need to change the .BAT file extension ''.BAT1' to '.BAT'

