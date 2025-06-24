FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    gnupg2 \
    ca-certificates \
    rclone \
    jellyfin \
    && rm -rf /var/lib/apt/lists/*

# Agregar repositorio oficial Jellyfin (por si jellyfin no está en los repos)
RUN wget -O - https://repo.jellyfin.org/jellyfin_team.gpg.key | apt-key add - \
    && echo "deb [arch=amd64] https://repo.jellyfin.org/ubuntu jammy main" > /etc/apt/sources.list.d/jellyfin.list \
    && apt-get update && apt-get install -y jellyfin

# Crear carpeta para futuros montajes (aunque no se usa mount)
RUN mkdir -p /mnt/drive

# Copiar script start.sh
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Exponer puertos Jellyfin y rclone serve http
EXPOSE 8096 8080

# Ejecutar start.sh al iniciar contenedor
CMD ["/start.sh"]
