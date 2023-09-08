#!/bin/bash

# Script downloaded from https://github.com/Creaous/Linux-Scripts
# This script requires sudo permissions!

# Directory where you want to store the LUKS header backups
backup_dir="." # Use . for current directory

# Create the backup directory if it doesn't exist
mkdir -p "$backup_dir"

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
    else
        echo "Backup failed for ${device}. Check permissions or device availability."
    fi
done

echo "All LUKS headers have been backed up."
