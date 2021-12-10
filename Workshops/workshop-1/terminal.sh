#Initiating SnowSQL
snowsql -a ht48847.canada-central.azure -u miguel_estrada_sbx;

#Using PUT Command
put file://c:\temp\load\contacts3.csv @my_csv_stage auto_compress=true overwrite=true;