import boto3

session = boto3.session.Session(profile_name="vinay")
ec2_client = session.client('ec2','ap-south-1')
list_of_instances=[]

response = ec2_client.run_instances(
    BlockDeviceMappings=[
        {
            'DeviceName': '/dev/xvda',
            'Ebs': {

                'DeleteOnTermination': True,
                'VolumeSize': 8,
                'VolumeType': 'gp2'
            },
        },
    ],
    ImageId='ami-022d03f649d12a49d',
    InstanceType='t2.micro',
    MaxCount=1,
    MinCount=1,
    Monitoring={
        'Enabled': False
    },
    SecurityGroupIds=[
        'sg-0c577fa9fe15f6eab',
    ],
)

list_of_instances.append(response.get('PrivateIpAddress'))

print("no of instances are:{}", list_of_instances)