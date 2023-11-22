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
   }     
]

a = aws()
print(a.names[0]["instance_type"])