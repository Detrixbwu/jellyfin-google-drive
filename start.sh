#!/bin/bash
set -e  # Salir si hay cualquier error

echo "==== Iniciando start.sh ===="

# Guardar configuración rclone desde variable de entorno
if [ -z "$RCLONE_CONF" ]; then
  echo "Error: la variable RCLONE_CONF no está definida."
  exit 1
fi

echo "Guardando configuración rclone..."
echo "$RCLONE_CONF" > /rclone.conf

echo "Iniciando rclone serve http en puerto 8080..."
rclone --config /rclone.conf serve http gdrive:/JellyfinLibrary --addr :8080 --vfs-cache-mode writes &
RCLONE_PID=$!

sleep 5

echo "Iniciando Jellyfin..."
if command -v jellyfin >/dev/null 2>&1; then
  jellyfin &
elif [ -f /usr/lib/jellyfin/jellyfin ]; then
  /usr/lib/jellyfin/jellyfin &
else
  echo "Error: Jellyfin no encontrado."
  kill $RCLONE_PID
  exit 1
fi

JELLYFIN_PID=$!

echo "Ambos procesos arrancados:"
echo "- rclone PID: $RCLONE_PID"
echo "- Jellyfin PID: $JELLYFIN_PID"

echo "Manteniendo el contenedor vivo..."
wait $RCLONE_PID $JELLYFIN_PID
