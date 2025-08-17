# Add values
# Find the Ubuntu server 22.04 AMI for your region at this URL
# https://cloud-images.ubuntu.com/locator/ec2/
imageid                = "ami-0d1b5a8c13042c939"
# Use t2.micro for the AWS Free Tier
instance-type          = "t2.micro"
key-name               = "coursera-key"
vpc_security_group_ids = "sg-023a045c83fdc42f5"
tag-name               = "module-02"
raw-bucket             = "module-02-raw-bucket"
finished-bucket        = "module-02-finished-bucket"
sns-topic              = "module-02-sns"
sqs                    = "module-02-sqs"
dbname                 = "module02db"
uname                  = "hle22"
pass                   = "hle2213579"
elb-name               = "module2-elb"
asg-name               = "module2-asg"
min                    = 2
max                    = 5
desired                = 3
tg-name                = "module2-tg"
cnt                    = 3