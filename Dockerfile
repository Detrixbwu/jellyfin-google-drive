FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias básicas y rclone
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg2 \
    ca-certificates \
    rclone \
    && rm -rf /var/lib/apt/lists/*

# Agregar llave pública de Jellyfin y repositorio oficial
RUN wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key | apt-key add - \
    && echo "deb [arch=amd64] https://repo.jellyfin.org/ubuntu jammy main" > /etc/apt/sources.list.d/jellyfin.list

# Actualizar repositorios e instalar Jellyfin con su interfaz web
RUN apt-get update && apt-get install -y \
    jellyfin \
    jellyfin-web \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /mnt/drive

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8096 8080

CMD ["/start.sh"]
