from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators import pythonoperator
import OS
import json
import numpy as np
from airflow.operators.dagrun_operator import TriggerDagRunOperator
from airflow.utils.dates import days_ago

default_args= {

'owner' : 'Janakiraman',
'depends_on_past' : False,
'email' : ['janakiramane22@gmail.com'],
'email_on_failure' : False,
'email_on_retry' : False,
'retries' : 5,
'retry_delay' : timedelta(minutes=1)

}
#This schedule will run on daily basis and it will start from tomorrow
dag = DAG(
dag_id='starwarsapi',
default_args=default_args,
start_date=datetime(2020,10,08),
schedule_interval=timedelta(minutes=1440))

#This task will get the JSON Data into File
task1 = BashOperator(
task_id='get_starwarsapi',
bash_command='python ~/airflow/dags/src/ExtractJSON_FROM_STARWARS_API.py',
dag=dag)

#IMPORTING JSON DATA TO DB
task2 = BashOperator(
task_id='import_jsondata',
bash_command='python ~/airflow/dags/src/STARWARS_API_Imports_DATA.py',
dag=dag)

#Task1 completed before the Task2
task1>>task2


#ELSE WE CAN USE TRIGGER MOTHOD

trigger = TriggerDagRunOperator(
    task_id="import_jsondata",
    trigger_dag_id="import_jsondata",  # Ensure this equals the dag_id of the DAG to trigger
    bash_command='python ~/airflow/dags/src/STARWARS_API_Imports_DATA.py',
    dag=dag)


