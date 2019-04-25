#!/bin/bash

cd /home/postgres
tar -xzf download    
cd /home/postgres/postgres-xl-9.5r1.4/
#Upcoming versions of glibc will contain copy_file_range(2), a wrapper
#around a new linux syscall for in-kernel copying of data ranges. This
#conflicts with pg_rewinds function of the same name.
# more information : 
# https://git.postgresql.org/gitweb/?p=postgresql.git;a=commitdiff;h=ea4cbf8f1050b490d3040e659598bee63494288d
sed -i 's/copy_file_range/rewinder_copy_file_range/g' src/bin/pg_rewind/copy_fetch.c
./configure
make
sudo make install
ufw disable
echo "PATH='/usr/local/pgsql/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games'" | sudo tee /etc/environment
# Create a SSH KEY
mkdir -p /home/postgres/.ssh
ssh-keygen -f /home/postgres/.ssh/id_rsa -t rsa -N ''
cat /home/postgres/.ssh/id_rsa.pub | tee -a /home/postgres/.ssh/authorized_keys
