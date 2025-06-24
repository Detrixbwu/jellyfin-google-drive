#!/bin/bash

# Guardar configuración rclone
echo "$RCLONE_CONF" > /rclone.conf

# Servir Google Drive por HTTP en puerto 8080 (sin FUSE)
rclone --config /rclone.conf serve http gdrive:/JellyfinLibrary --addr :8080 --vfs-cache-mode writes &

# Iniciar Jellyfin (usa systemctl o el comando directo)
/usr/lib/jellyfin/jellyfin &

# Mantener el container vivo
tail -f /dev/null
