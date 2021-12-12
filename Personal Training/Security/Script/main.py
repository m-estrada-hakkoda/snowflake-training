import pandas
import os
from dotenv import load_dotenv
import snowflake.connector

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib
import base64

class EmailManager():
    def __init__(self):
        print("Initiating SMTP encrypted services...")
        self.SMTP_SERVICE = smtplib.SMTP('smtp.gmail.com', 587) 
        self.SMTP_SERVICE.starttls()
        self.SMTP_SERVICE.login(os.environ.get("EMAIL"), os.environ.get("EMAIL_PASSWORD"))

    def general_processing(self)->None:
        print("Creating email/s...")
        self.msg["Subject"] = "My Subject"
        self.msg["From"] = os.environ.get("EMAIL")
        self.msg["To"] = 'recipient-1@email.com,recipient-2@email.com'
        body = self.mime_processing
        self.msg.attach(body)

    def mime_processing(self):
        print("Creating email template...")

    def send(self, users_emails:list)->None:
        print("Sending email/s...")
        self.general_processing()
        self.SMTP_SERVICE.sendmail(self.msg["From"], self.msg["To"].split(","), self.msg.as_string())

    def __del__(self):
        print("Closing connection to SMTP encrypted services...")
        self.SMTP_SERVICE.quit()

class SecurityManager(EmailManager):
    connection = None
    cursor = None
    warehouse = ''
    account = ''
    user = ''
    password = ''
    database = ''
    schema = ''
    def __init__(self):
        print("Getting set up...")
        dotenv_path = os.path.join(os.path.dirname(__file__), '.env')
        load_dotenv(dotenv_path)
        self.warehouse = os.environ.get("WAREHOUSE")
        self.account = os.environ.get("ACCOUNT")
        self.user = os.environ.get("USER")
        self.password = os.environ.get("PASSWORD")
        self.database = os.environ.get("DATABASE")
        self.schema = os.environ.get("SCHEMA")
        #Creating connection
        self.connection = self.connection()

    @property
    def connection(self)->snowflake.connector.connect:
        if self.connection == None:
            print("Initiating connection to Snowflake API...")
            return self.connection
        else:
            print("Renewing connection...")
            return self.connection

    @connection.setter
    def connection(self)->None:
        self.connection = snowflake.connector.connect(
                user = self.user,
                password=self.password,
                account=self.account,
                warehouse=self.warehouse,
                database=self.database,
                schema=self.schema
                )
        self.cursor = self.connection.cursor()

    def execute(self, sql:str, all:bool)->str:
        print("Executing SQL in Snowflake...")

    def __del__(self):
        print("Finishing actions and closing connections...")

if __name__ == "__main__":
    print("Executing actions")