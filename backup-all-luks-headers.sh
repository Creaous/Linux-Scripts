#!/bin/bash

# Script downloaded from https://github.com/Creaous/Linux-Scripts
# This script requires sudo permissions!

# Check if the script is running with sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "This script requires sudo privileges."
  # Use sudo to execute the script with elevated privileges
  exec sudo "$0" "$@"
fi

# Directory where you want to store the LUKS header backups
backup_dir="./backup/luks/headers" # Use . for current directory

# Create the backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Get the username of the currently logged-in user
current_user=$(logname)

# Get a list of LUKS-encrypted devices
luks_devices=$(lsblk -o NAME,TYPE,FSTYPE | grep crypto_LUKS | sed 's/[├─└─]//g' | awk '{print $1}')

# Loop through each LUKS device and backup its header
for device in $luks_devices; do
    header_backup_file="${backup_dir}/${device}_luks_header.img"
    
    echo "Backing up LUKS header for ${device} to ${header_backup_file}"
    
    # Backup the LUKS header
    sudo cryptsetup luksHeaderBackup "/dev/${device}" --header-backup-file "$header_backup_file"
    
    if [ $? -eq 0 ]; then
        echo "Backup successful."
        echo
    else
        echo "Backup failed for ${device}. Check permissions or device availability."
        echo
    fi
done

echo "All LUKS headers have been backed up."

echo

# Set appropriate permissions on the backup folder (e.g., allow full control for the owner and read/execute permissions for group and others)
sudo chmod -R 755 "$backup_dir"
echo "Setting permissions on ${backup_dir} to 755 (allows full control for the owner and read/execute permissions for group and others)"

echo

# Change ownership of the backup file to the current user and inherit parent directory permissions
sudo chown -R "$current_user:$current_user" "$backup_dir"
echo "Changing ownership of ${backup_dir} to ${current_user} and inheriting permissions from parent directory."
