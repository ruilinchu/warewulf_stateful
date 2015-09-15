#!/bin/bash

yum --installroot=/var/chroots/centos-6-stateful install kernel grub
wwvnfs --chroot /var/chroots/centos-6-stateful

./ww-configure-stateful.sh c001 500 sda
./ww-configure-stateful.sh c002 500 sda
./ww-configure-stateful.sh c003 500 sda
./ww-configure-stateful.sh c004 500 sda
