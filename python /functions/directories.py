class aws:

   names = [
    {
     "instance_name" : "jenkins-build-server",
     "instance_type" : "t2.medium",
     "region" : "ap-south-1"
   },
   {
    "instance_name" : "EKS",
     "instance_type" : "t2.xlarge",
     "region" : "ap-south-1"
   },
   {
    "instance_name" : "Docker",
     "instance_type" : "t3.xlarge",
     "region" : "ap-south-1",
     "zone"  :  "ap-south-1a"
   }    
]

a = aws()
print(a.names[0]["instance_type"], a.names[2]["zone"])