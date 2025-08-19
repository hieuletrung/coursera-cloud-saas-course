# Add values
# Find the Ubuntu server 22.04 AMI for your region at this URL
# https://cloud-images.ubuntu.com/locator/ec2/
# Custom AMI ID
imageid                = "ami-0d0ca13c9d705e3dc"
# Use t2.micro for the AWS Free Tier
instance-type          = "t2.micro"
key-name               = ""
vpc_security_group_ids = ""
cnt                    = 1
tag-name               = ""
raw-s3                 = ""
finished-s3            = ""
user-sns-topic         = ""
elb-name               = ""
tg-name                = ""
asg-name               = ""
desired                = 3
min                    = 2
max                    = 5
number-of-azs          = 3
region                 = "us-east-2"
raw-s3-bucket          = ""
finished-s3-bucket     = ""
dbname                 = ""
snapshot_identifier    = ""
sqs-name               = ""
username               = ""
