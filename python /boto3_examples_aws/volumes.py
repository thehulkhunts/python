#! /usr/bin/python

#describe volumes in your account

import boto3
from pprint import pprint

session=boto3.session.Session(profile_name="vinay")

ec2=session.client('ec2','ap-south-1')

list_of_volume_ids=[]

for each_volume in ec2.describe_volumes()['Volumes']:
    list_of_volume_ids.append(each_volume['VolumeId'])
    print("list of volumes are:", list_of_volume_ids)

for each_vol in list_of_volume_ids:
    print "taking snaps of volume{}".format(each_vol)
    snap_ids=[]
    response=ec2.create_snapshot(
            Description="taking snapshots of volumes listed",
            VolumeId=each_vol,
            TagSpecifications=[
                {
                    'ResourceType':'snapshot',
                    'Tags':[
                        {
                            'indication':'delete_on',
                            'days_required':'90'
                        }
                           ]
                }
              ]
             )
    snap_ids.append(response.get('SnapshotID'))
print "the snap ids are:", snap_ids

waiter=ec2.client('snapshot_completed')
waiter.wait(SnapshotIds=snap_ids)

print "successfully completed snapshots for volumes {}".format(list_of_volume_ids)
        

