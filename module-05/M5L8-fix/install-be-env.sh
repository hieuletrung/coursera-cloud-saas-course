#!/bin/bash

# Install Backend dependecies here:

##############################################################################
# Installing Python Pip and library Dependencies
##############################################################################
sudo apt update -y
sudo apt install -y python3-dev python3-setuptools python3-pip python3-venv
#sudo -u ubuntu python3 -m pip install pip --upgrade
#python3 -m pip install pillow
#python3 -m pip install boto3
#python3 -m pip install mysql-connector-python

cd /home/ubuntu
sudo -u ubuntu python3 -m venv venv
. venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install pillow
python3 -m pip install boto3
python3 -m pip install mysql-connector-python

cd /home/ubuntu

# Command to clone your private repo via SSH usign the Private key
####################################################################
# Note - change "hajek.git" to be your private repo name (hawk ID) #
####################################################################
sudo -u ubuntu git clone git@github.com:hieuletrung/coursera-cloud-saas-course.git

# Start the nodejs app where it is located via PM2
# https://pm2.keymetrics.io/docs/usage/quick-start
cd /home/ubuntu/coursera-cloud-saas-course/module-05/M5L8-fix

echo "Copying ./app.py to /usr/local/bin/..." 
sudo cp ./app.py /usr/local/bin/
echo "Copying ./checkqueue.timer to /etc/systemd/system/..."
sudo cp ./checkqueue.timer /etc/systemd/system/
echo "Copying ./checkqueue.service to /etc/systemd/system/..."
sudo cp ./checkqueue.service /etc/systemd/system/

sudo systemctl enable --now checkqueue.timer
sudo systemctl enable checkqueue.service
