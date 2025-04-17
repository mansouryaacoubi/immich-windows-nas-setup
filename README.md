## Guide to install Immich on Windows using a Network Drive

```ps1
winget install -e --id Docker.DockerDesktop
start "C:\Program Files\Docker\Docker\Docker Desktop.exe"
# Wait for Docker to startup and do the config steps
wsl --distribution docker-desktop
```

```sh
cd /root
wget https://raw.githubusercontent.com/mansouryaacoubi/immich-windows-nas-setup/refs/heads/main/setup-network-drive.sh
chmod +x setup-network-drive.sh
./setup-network-drive.sh
exit
```

```ps1
wget https://raw.githubusercontent.com/mansouryaacoubi/immich-windows-nas-setup/refs/heads/main/install-immich.ps1
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
./install-immich.ps1
# TODO: Make container start automatically when Windows boots up
```
