import boto3

session = boto3.session.Session(profile_name="vinay")
ec2_vol_client = session.client('ec2','ap-south-1')

list_of_volumes = []

for each_vol in ec2_vol_client.describe_volumes()['Volumes']:
    list_of_volumes.append(each_vol['VolumeId'])
    print("no of volumes are:", list_of_volumes)

for volumes in list_of_volumes:
    print("Taking snapshots for listed volumes:{}".format(volumes))

    snap_ids = []

    res = ec2_vol_client.create_snapshot(
        Description='taking snapshots for volumes',
        VolumeId=volumes,
        TagSpecifications=[
            {
                'ResourceType':'snapshot',
                'Tags': [
                {
                    'Key': 'Depends_on',
                    'Value': '90days'
                },
              ]
            },
        ]
    )
    snap_ids.append(res.get('SnapshotId'))
    print("snapshot ids are:", snap_ids)

    #waiter = ec2_vol_client.client('snapshot_completed')
    #waiter.wait(SnapshotIds=snap_ids)

    print("successfuly completed snapshot for volumes:{}".format(list_of_volumes))