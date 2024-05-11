#!/bin/bash

# Interactive Raspberry Pi SD Card Backup and Restore Script with Confirmation Check

echo "Raspberry Pi SD Card Backup and Restore Utility"

# Default paths - MODIFY THESE AS NEEDED
DEFAULT_BACKUP_PATH="$HOME/Desktop/RPi_Backup.img"
DEFAULT_IMAGE_PATH="$HOME/Desktop/RPi_Backup.img.gz"

# Function to list and select a drive
select_drive() {
    echo "Available Drives:"
    diskutil list
    read -p "Enter the identifier of the drive (e.g., 'disk2' for /dev/disk2): " diskid
    SELECTED_DRIVE="/dev/$diskid"
}

# Function for confirmation with warning
confirm_operation() {
    echo "WARNING: This operation will modify the disk at $SELECTED_DRIVE."
    echo "All data on the target disk will be overwritten and cannot be recovered."
    read -p "Are you sure you want to proceed? (yes/no): " confirmation
    if [[ $confirmation != "yes" ]]; then
        echo "Operation aborted by the user."
        exit 1
    fi
}

# Function to backup SD Card
backup_sd_card() {
    select_drive
    confirm_operation
    backup_path=$DEFAULT_BACKUP_PATH
    read -p "Enter the path for the backup image file [$DEFAULT_BACKUP_PATH]: " input_backup_path
    if [ ! -z "$input_backup_path" ]; then
        backup_path=$input_backup_path
    fi
    echo "Starting SD card backup from $SELECTED_DRIVE to $backup_path..."
    sudo dd bs=4M if=$SELECTED_DRIVE of=$backup_path status=progress
    echo "Backup completed."
    gzip $backup_path
    echo "Backup compressed to $backup_path.gz"
}

restore_sd_card() {
    select_drive
    confirm_operation
    image_path=$DEFAULT_IMAGE_PATH
    read -p "Enter the path of the image file to restore [$DEFAULT_IMAGE_PATH]: " input_image_path
    if [ ! -z "$input_image_path" ]; then
        image_path=$input_image_path
    fi

    # Check if the drive is mounted and unmount it if necessary
    echo "Checking if $SELECTED_DRIVE is mounted..."
    if mount | grep -q $SELECTED_DRIVE; then
        echo "$SELECTED_DRIVE is mounted. Unmounting..."
        diskutil unmountDisk $SELECTED_DRIVE
        if [ $? -ne 0 ]; then
            echo "Failed to unmount $SELECTED_DRIVE. Please manually unmount and try again."
            exit 1
        fi
    fi

    echo "Restoring $image_path to $SELECTED_DRIVE..."
    gunzip -c $image_path | sudo dd bs=4M of=$SELECTED_DRIVE status=progress
    echo "Restore completed."
}

# Main menu
echo "Select operation:"
echo "1. Backup SD Card"
echo "2. Restore SD Card"
read -p "Enter your choice (1 or 2): " operation

case $operation in
    1) backup_sd_card ;;
    2) restore_sd_card ;;
    *) echo "Invalid option selected"; exit 1 ;;
esac

echo "Operation completed."
