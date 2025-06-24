FROM ubuntu:22.04

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg2 \
    ca-certificates \
    fuse \
    rclone \
    systemctl \
    && rm -rf /var/lib/apt/lists/*

# Instalar Jellyfin
RUN wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key | apt-key add -
RUN echo "deb [arch=amd64] https://repo.jellyfin.org/ubuntu jammy main" > /etc/apt/sources.list.d/jellyfin.list
RUN apt-get update && apt-get install -y jellyfin

# Crear carpeta para montar (aunque no montamos con rclone mount)
RUN mkdir -p /mnt/drive

# Copiar el script de inicio
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Exponer puertos para Jellyfin y rclone serve http
EXPOSE 8096 8080

# Comando para iniciar el contenedor
CMD ["/start.sh"]
