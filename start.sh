#!/bin/bash

# Guardar rclone.conf en archivo
echo "$RCLONE_CONF" > rclone.conf

# Instalar rclone
curl https://rclone.org/install.sh | bash

# Crear carpeta para montar Google Drive
mkdir -p /mnt/drive

# Montar Google Drive (con la carpeta JellyfinLibrary)
rclone --config rclone.conf mount gdrive:/JellyfinLibrary /mnt/drive --vfs-cache-mode writes &

# Instalar Jellyfin
sudo apt-get update
sudo apt-get install -y jellyfin

# Iniciar Jellyfin
sudo service jellyfin start

# Mantener el script corriendo para que no se cierre
tail -f /dev/null
