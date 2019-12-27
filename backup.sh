#!/bin/sh

# back up critical sys files & warewulf config/data to zfs

#mysqldump warewulf > /backup/warwulf.sql
wwsh node print > /backup/ww_node
wwsh provision print > /backup/ww_provision
wwsh file print > /backup/ww_file
wwsh ipmi print > /backup/ww_ipmi

for dir in \
/etc/sysconfig/network-scripts \
/etc/hosts \
/etc/warewulf \
/etc/passwd \
/etc/group \
/etc/shadow \
/etc/ssh \
/etc/security \
/etc/pam.d \
/var/chroots \
/srv/warewulf ; do

rsync -arR $dir /backup/

done

yum list installed > /backup/yum_installed
