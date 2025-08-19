# Add values
# Find the Ubuntu server 22.04 AMI for your region at this URL
# https://cloud-images.ubuntu.com/locator/ec2/
# Custom AMI ID
imageid                = "ami-0d0ca13c9d705e3dc"
# Use t2.micro for the AWS Free Tier
instance-type          = "t2.micro"
key-name               = "coursera-key"
vpc_security_group_ids = "sg-023a045c83fdc42f5"
tag-name               = "module-04"
raw-s3                 = "module-04-raw-bucket"
finished-s3            = "module-04-finished-bucket"
user-sns-topic         = "module-04-sns"
elb-name               = "module-04-elb"
tg-name                = "module-04-tg"
asg-name               = "module-04-asg"
desired                = 3
min                    = 2
max                    = 5
number-of-azs          = 3
region                 = "us-east-2"
raw-s3-bucket          = "module-04-raw-bucket"
finished-s3-bucket     = "module-04-finished-bucket"
dbname                 = "company"
snapshot_identifier    = "module04dbsnapshot"
sqs-name               = "module-04-sqs"
username               = "controller"
