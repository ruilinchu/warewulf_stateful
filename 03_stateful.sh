#!/bin/bash

yum --installroot=/var/chroots/centos-6-stateful install kernel grub
wwvnfs --chroot /var/chroots/centos-6-stateful


