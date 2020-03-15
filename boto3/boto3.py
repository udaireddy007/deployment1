#!/usr/bin/env python
import boto3
client = boto3.client('s3')
response = client.get_object(Bucket='<bucket_name>',Key='<path of object>') # enter your bucet and key
print(response)


Note: ./boto.py (this gives complete info of object)
