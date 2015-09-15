#!/bin/bash

yum -y --installroot=/var/chroots/centos-6-stateful install kernel grub

cp -f /etc/passwd /var/chroots/centos-6-stateful/etc
cp -f /etc/group /var/chroots/centos-6-stateful/etc
cp -f /etc/shadow /var/chroots/centos-6-stateful/etc

wwvnfs -y --chroot /var/chroots/centos-6-stateful

./ww-configure-stateful.sh c001 500 sda
./ww-configure-stateful.sh c002 500 sda
./ww-configure-stateful.sh c003 500 sda
./ww-configure-stateful.sh c004 500 sda
