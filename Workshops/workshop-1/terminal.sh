#Initiating SnowSQL
snowsql -a ht48847.canada-central.azure -u miguel_estrada_sbx;

#Defining context
USE DATABASE "BEETLE_WORKSHOPS";
USE SCHEMA "BEETLE_WORKSHOPS_SCHEMA";

#Using PUT Command
put file://c:\temp\load\contacts3.csv @my_csv_stage auto_compress=true overwrite=true;