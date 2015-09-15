#!/bin/bash

## set passwd first time, you can omit this and go straight to wwinit ALL
## but later slurm will need it
mysqladmin -u root password 'password'
## warewulf creates warewulf database automatically
## mysql -u root -e "create database warewulf;" -p'password'
## or use: mysqladmin create warewulf -p'password'

## warewulf mysql set up
sed -i '/database user/c\database user = root' /etc/warewulf/database.conf
sed -i '/database password/c\database password = password'  /etc/warewulf/database.conf
sed -i '/database password/c\database password = password' /etc/warewulf/database-root.conf

## first init, vnfs will fail, but will set /etc/fstab correct, wierd?
wwinit ALL

echo warewulf making chroot ... 
#centos-6 is a template provided by warewulf in /usr/libexec/warewulf/wwmkchroot/
wwmkchroot centos-6 /var/chroots/centos-6-stateful

## install nptd to comupte nodes to sync time with master
yum --tolerant --installroot /var/chroots/centos-6-stateful -y install ntp warewulf-monitor-legacy-wulfd

sed -i '/centos.pool.ntp.org/c\server 172.16.2.250' /var/chroots/centos-6-stateful/etc/ntp.conf

chroot /var/chroots/centos-6-stateful/ chkconfig ntpd on

sed -i '/WAREWULF_MASTER/c\WAREWULF_MASTER=172.16.2.250' /var/chroots/centos-6-stateful/etc/sysconfig/wulfd.conf

HOSTLIST=`grep eth0 /etc/hosts | awk '{print $3}' | paste -d, -s`
sed -i "/WAREWULFD_HOSTS/c\WAREWULFD_HOSTS=$HOSTLIST " /etc/sysconfig/wwproxy.conf

#echo warewulf initiating ...
#CHROOTDIR=/var/chroots/centos-6 wwinit ALL
wwvnfs --chroot /var/chroots/centos-6-stateful
echo @
echo @
echo @
echo "warewulf scanning and adding nodes"
echo "please set compute nodes to PXE boot and bring up them one by one in order"
echo "when all nodes are recorded stop(ctl-c) this script"
echo @
echo @
echo @
sleep 3
wwnodescan --netdev=eth0 --ipaddr=172.16.0.1 --netmask=255.255.0.0 --vnfs=centos-6-stateful --bootstrap=`uname -r` --groups=compute c[001-999]

