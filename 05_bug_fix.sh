#!/bin/bash

## bug in version 3.6, not in latest trunk
## need to fix /boot/grub/grub.conf so the nodes boot up! remove console= in kernel line
pdsh -w `grep eth0 /etc/hosts | awk '{print $1}' | paste -d, -s ` "sed -i 's+console=+ +g' /boot/grub/grub.conf"

./ww-disable-stateful.sh c[001-004]

./reboot_all