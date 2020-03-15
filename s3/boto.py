#!/usr/bin/env python
import boto3
client = boto3.client('s3')
response = client.get_object(Bucket='fmc-prod-repo-usw2',Key='repository/keyframe/vol10/1/keyframe_00572e19003cc9a22ce4b3f1e13913e8b8b9d495') # enter your bucet and key
print(response)
