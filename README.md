# Guide to install Immich on Windows using a Network Drive

## Start Docker Desktop

## Connect NAS to Docker Desktop WSL
1. wsl --distribution docker-desktop
2. mkdir -p /mnt/z
3. Edit /etc/fstab and add //192.168.178.134/Public /mnt/z cifs auto,username=YaacoubiCloud,password=redacted 0 0
4. mount -a
5. Check /mnt/z whether it has been mounted

## Install immich on Windows
1. mkdir ./immich-app
2. cd ./immich-app
3. wget -O docker-compose.yml https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml
4. wget -O .env https://github.com/immich-app/immich/releases/latest/download/example.env
5. Change UPLOAD_LOCATION in .env to /mnt/z/ImmichData/upload
6. Change DB_PASSWORD to custom one (use only A-Za-z0-9)
7. Set TZ to Europe/Berlin

## Start container
1. docker compose up -d
2. Make container start automatically when Windows boots up

# Short Guide

1. Install Docker Desktop
2. Start Docker Desktop
3. wsl --distribution docker-desktop
4. cd /root
5. wget https://gist.githubusercontent.com/mansouryaacoubi/7b021206efa4a1c4ff95b4e851d23902/raw/6667a7ef46fc9640d8e7692c9611e35837d3ca90/setup-network-drive.sh
6. chmod +x setup-network-drive.sh
7. ./setup-network-drive.sh
8. exit
9. Execute Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
10. ./install-immich.ps1
