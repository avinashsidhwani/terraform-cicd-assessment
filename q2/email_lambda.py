import json
import boto3
import os

def lambda_handler(event, context):
  """
    Publishes a "Hello World!" message to a SNS Topic
    :param event: Event
    :param context: Context
    :return: None
  """
  sns = boto3.client('sns')

  # publish message to SNS topic
  response = sns.publish(
  TopicArn=os.environ['SNS_ARN'],
  Message='Hello World!',
  )

  print(response)
  
  return {
    'statusCode': 200,
    'body': json.dumps('Hello from Lambda!')
  }