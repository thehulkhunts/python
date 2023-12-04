#! /usr/bin/python
import boto3

session=boto3.session.Session(profile_name="vinay")
resource=session.resource('ec2','ap-south-1')
client=session.client('ec2','ap-south-1')
profile=session.client('sts')
aws_account=profile.get_caller_identity().get('Account')

count=1
for snap in resource.snapshots.filter(OwnerIds=[aws_account]):
    print(count,snap)
    count=count+1
