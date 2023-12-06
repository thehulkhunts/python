import sys

try:
    import boto3
    print("imported boto3 successfully")
except Exception as e:
    print(e)
    sys.exit(1)

source_region = "ap-south-1"
destination_region = "us-east-1"

session = boto3.session.Session(profile_name="vinay")
ec2_client = session.client(service_name="ec2", region_name=source_region)

profile = session.client(service_name='sts', region_name=source_region)
AWS = profile.get_caller_identity().get('Account')

snaps=[]

backup_snaps = {'Name':'tag:backup','Values':['Yes']} #standard dictionary where "key=value?is backup:yes"

for each_snap in ec2_client.describe_snapshots(OwnerIds=[AWS],Filters=[backup_snaps])['Snapshots']:
    snaps.append(each_snap['SnapshotId'])
    print(f"listed snapshots are to backup is{snaps}")

#create an object to transfer to another region 

ec2_dest_client = session.client(service_name='ec2',region_name=destination_region)

for each_bkp_snap in snaps:
    print("taking backup of snaps to another region{}".format(each_bkp_snap,destination_region))
    ec2_dest_client.copy_snapshot(
        Description="copying source snaps as a backup for disaster recovery",
        SourceRegion=source_region,
        SourceSnapshotId=each_bkp_snap
    )
print(f"Snapshots have been copied to destination region : {destination_region}.....")


#once bakup snaps to another region try to change the tags for better understanding 
print("modifying tags of snapshots after backup completed")

for each_src_snap in snaps:
    print("modifying existing tags{}".format(each_src_snap,destination_region))
    ec2_client.delete_tags(
        Resources=[each_src_snap],
        Tags=[
            {
                'Key':'backup',
                'Value':'Yes'
            }
        ]
    )
    print("creating tags for backup snapshotsas completed in source region{}".format(each_src_snap,destination_region))
    ec2_client.create_tags(
        Resources=[each_src_snap],
        Tags=[
            {
                'Key':'backup',
                'Value':'completed'
            }
        ]
    )


