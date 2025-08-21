import boto3
from io import BytesIO
from PIL import Image
import logging
from botocore.exceptions import ClientError
from botocore.config import Config
from urllib.parse import urlparse
import os

region = 'us-east-2'

clientDynamo = boto3.client('dynamodb', region_name=region)
clientSNS = boto3.client('sns', region_name=region)
clientS3 = boto3.client('s3', region_name=region, config=Config(s3={'addressing_style': 'path'}, signature_version='s3v4'))

def lambda_handler(event, context):
    # Get S3 bucket and key from event
    try:
        record = event['Records'][0]
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key']
    except Exception as e:
        logging.error(f"Error parsing event: {e}")
        return

    print(f"Triggered by S3 upload: bucket={bucket}, key={key}")

    # Download image from S3
    try:
        responseGetObject = clientS3.get_object(Bucket=bucket, Key=key)
        file_byte_string = responseGetObject['Body'].read()
    except ClientError as e:
        logging.error(e)
        return

    # Convert to grayscale
    try:
        im = Image.open(BytesIO(file_byte_string))
        im = im.convert("L")
        file_name = "/tmp/grayscale-" + os.path.basename(key)
        im.save(file_name)
    except Exception as e:
        logging.error(f"Error processing image: {e}")
        return

    # Upload grayscale image to finished bucket
    finished_bucket = 'module-07-finished-bucket'
    try:
        clientS3.upload_file(file_name, finished_bucket, key)
    except ClientError as e:
        logging.error(e)
        return

    # Generate presigned URL
    try:
        responsePresigned = clientS3.generate_presigned_url('get_object', Params={'Bucket': finished_bucket, 'Key': key}, ExpiresIn=7200)
    except ClientError as e:
        logging.error(e)
        responsePresigned = ""

    # Update DynamoDB: set FINSIHEDS3URL and RAWS3URL
    dynamo_table = 'module-07-dynamodb'
    record_number = key  # Assuming key is used as RecordNumber
    try:
        clientDynamo.update_item(
            TableName=dynamo_table,
            Key={'RecordNumber': {'S': record_number}},
            UpdateExpression="SET FINSIHEDS3URL = :url, RAWS3URL = :done",
            ExpressionAttributeValues={
                ':url': {'S': str(responsePresigned)},
                ':done': {'S': 'done'}
            }
        )
        
    except ClientError as e:
        logging.error(e)

    # Publish to SNS
    try:
        responseTopics = clientSNS.list_topics()
        topic_arn = responseTopics['Topics'][0]['TopicArn']
        messageToSend = f"Your image: {file_name} is ready for download at: {responsePresigned}"
        clientSNS.publish(
            TopicArn=topic_arn,
            Subject="Your image is ready for download!",
            Message=messageToSend,
        )
    except Exception as e:
        logging.error(e)

    print("Lambda function completed successfully.")