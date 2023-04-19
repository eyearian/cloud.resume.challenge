# import boto3

# client = boto3.client('dynamodb')

# def handler(event, context):
#   data = client.get_item(
#     TableName='visit_count',
#     Item={
#         'visit_count': {
#           'S': '0'
#         }
#     }
#   )

#   response = {
#       'statusCode': 200,
#       'body': 'successfully created item!',
#       'headers': {
#         'Content-Type': 'application/json',
#         'Access-Control-Allow-Origin': '*'
#       },
#   }
  
#   return data['Item']['record_count']



#need to have a handler that gets the current record_count and one that updates the record_count
#or a method that returns the value of the record_count after being incremented

#aws dynamodb get-item --table-name visit_count --key '{"visit_count":{"S":"1"}}'

import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('visit_count')

def handler(event, context):
    response = table.get_item(Key={
            'record_id':'0'
    })
    record_count = response['Item']['record_count']
    record_count = record_count + 1
    print(record_count)
    response = table.put_item(Item={
            'record_id':'0',
            'record_count': record_count
    })
    
    return "Records added successfully!"
