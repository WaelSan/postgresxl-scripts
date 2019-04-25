#!/bin/bash
# Create postgres user in each server
useradd postgres --shell /bin/bash --home /home/postgres --create-home
echo -e 'postgres\npostgres\n' | sudo passwd postgres
# Add postgres user to sudo group
adduser postgres sudo
chsh -s /bin/bash postgres
# Install Dependencies
apt-get update -y
sudo apt --fix-broken install python-pycurl python-apt -y
apt-get install software-properties-common -y 
apt-get install wget zip gcc libreadline6 libreadline6-dev zlib1g-dev build-essential flex -y
# Clone postgres-xl
cd /home/postgres
wget https://sourceforge.net/projects/postgres-xl/files/latest/download

