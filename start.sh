#!/bin/bash

echo "$RCLONE_CONF" > /rclone.conf

rclone --config /rclone.conf mount gdrive:/JellyfinLibrary /mnt/drive --vfs-cache-mode writes &

service jellyfin start

tail -f /dev/null
