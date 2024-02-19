#! /bin/bash

sudo yum install git -y
sudo yum install maven -y
sudo yum install java-1.8.0-openjdk-devel -y

if [-d "addressbook"]
then
    echo "repo is already cloned"
    cd /home/ec2-user/addressbook
    git pull origin1 master
else
    git clone https://github.com/ereshre/addressbook.git
    git checkout master
fi
cd addressbook
mvn package