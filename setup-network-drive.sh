#!/bin/sh

# Check if we're inside Docker Desktop WSL
if [[ "$(hostname)" != "docker-desktop" ]]; then
    echo "❌ Please run this script inside the 'docker-desktop' WSL distro:"
    echo "👉 wsl --distribution docker-desktop"
    exit 1
fi

read -rp "Enter NAS IP: " NAS_IP
NAS_SHARE="Public"
MOUNT_POINT="/mnt/z"

# Prompt for credentials
read -rp "Enter NAS username: " NAS_USER
read -rsp "Enter NAS password: " NAS_PASS
echo

# Create mount point
mkdir -p "$MOUNT_POINT"

# Add fstab entry if not present
FSTAB_LINE="//${NAS_IP}/${NAS_SHARE} ${MOUNT_POINT} cifs username=$NAS_USER,password=$NAS_PASS,auto,nofail,vers=3.0 0 0"
if ! grep -qF "$FSTAB_LINE" /etc/fstab; then
    echo "$FSTAB_LINE" | tee -a /etc/fstab
fi

# Mount the drive
mount -a

# Confirm success
if mountpoint -q "$MOUNT_POINT"; then
    echo "✅ NAS mounted at $MOUNT_POINT"
else
    echo "❌ Mount failed. Check network and credentials."
fi
