import boto3
import json

# object of s3 bucket
s3_client = boto3.client(service_name='s3', region_name='ap-south-1') 

# object of dynamodb table
dynamodb_client = boto3.resource(service_name='dynamodb', region_name='ap-south-1') 
def lambda_handler(event, context):

    #event triggering using cloudwatch getting metrics in json 
    bucket = event['Records'][0]['s3']['bucket']['name'] 
    json_file = event['Records'][0]['s3']['object']['key'] 

    #getting information of bucket and file details
    json_object = s3_client.get_object(Bucket=bucket, key=json_file) 

    #response syntax is in body so using ['Body]'
    jsonFileReader = json_object['Body'].read() 

    #loaded the data into dictonary format using json.load()
    jsonDict = json.load(jsonFileReader) 

    #name of the dynamodb table
    table = dynamodb_client.Table('name of the table')

    #putting item into table using put_item method
    table.put_item(Item=jsonDict) 

    print(f"data has benn transfered to dynamodb table from s3 bucket")




