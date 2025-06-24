FROM ubuntu:22.04

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

# Crear directorio para montar Google Drive
RUN mkdir -p /mnt/drive

# Copiar script start.sh
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8096

CMD ["/start.sh"]
