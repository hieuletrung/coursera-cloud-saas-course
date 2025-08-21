# Add values
# Use the AMI of the custom Ec2 image you previously created
imageid                = "ami-0d0ca13c9d705e3dc"
# Use t2.micro for the AWS Free Tier
instance-type          = "t2.micro"
key-name               = "coursera-key"
vpc_security_group_ids = "sg-023a045c83fdc42f5"
tag-name               = "module-06"
user-sns-topic         = "module-06-updates"
elb-name               = "module-06-elb"
tg-name                = "module-06-tg"
asg-name               = "module-06-asg"
desired                = 3
min                    = 2
max                    = 5
number-of-azs          = 3
region                 = "us-east-2"
raw-s3-bucket          = "module-06-raw-bucket"
finished-s3-bucket     = "module-06-finished-bucket"
sqs-name               = "module-06-sqs"
dynamodb-name          = "company"