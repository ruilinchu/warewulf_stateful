#!/bin/bash

yum --tolerant --installroot /var/chroots/centos-6-stateful -y install kernel grub

cp -f /etc/passwd  /var/chroots/centos-6-stateful/etc
cp -f /etc/group  /var/chroots/centos-6-stateful/etc
cp -f /etc/shadow  /var/chroots/centos-6-stateful/etc

wwvnfs -y --chroot /var/chroots/centos-6-stateful

./ww-configure-stateful.sh c[001-004] 500 sda

