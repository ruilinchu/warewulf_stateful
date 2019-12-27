
[]# cat /etc/cron.d/backup
PATH="/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

0 0 * * * root /backup/backup.sh &> /var/log/backup
[]# cat /etc/cron.d/zfs-auto-snapshot
PATH="/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"

0 2 * * * root which zfs-auto-snapshot > /dev/null || exit 0 ; zfs-auto-snapshot --quiet --syslog --label=daily --keep=14 //
