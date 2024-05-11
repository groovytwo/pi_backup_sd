# Raspberry Pi SD Card Backup and Restore Guide

## Overview
This guide details the usage of an interactive script designed for backing up and restoring Raspberry Pi SD cards. It includes a user-friendly interface for selecting drives and paths, along with a confirmation step to prevent accidental data loss.

## Prerequisites
- A Unix-like operating system (Linux/macOS)
- Bash shell
- `sudo` privileges
- An SD card reader

## Script Features
- **Interactive Drive Selection:** Lists available drives and allows selection of the target or source drive.
- **Customizable Path for Backup/Restore:** Set default paths or enter a path during execution.
- **Backup:** Creates an image file of the SD card.
- **Restore:** Writes an image file to an SD card.
- **Confirmation Step:** Provides a warning and requires confirmation before proceeding with backup or restore.

## Usage

### 1. Running the Script
- Make the script executable:
  ```bash
  chmod +x sd_back_restore.sh
  ```
- Execute the script with `sudo`:
  ```bash
  sudo ./sd_back_restore.sh
  ```

### 2. Selecting Operation
- The script prompts you to choose an operation:
  ```
  Select operation:
  1. Backup SD Card
  2. Restore SD Card
  Enter your choice (1 or 2):
  ```
- Enter `1` for backup or `2` for restore.

### 3. Backup SD Card
- **Select Drive:** The script lists all drives. Enter the identifier for your SD card.
- **Confirmation:** A warning is displayed. Type `yes` to proceed.
- **Enter Backup Path:** The script shows the default path. Press Enter to accept or enter a new path.
- The script creates a `.img` file of the SD card and compresses it to `.gz`.

### 4. Restore SD Card
- **Select Drive:** Choose the drive where you want to restore the image.
- **Confirmation:** A warning is displayed. Type `yes` to proceed.
- **Enter Image Path:** The script shows the default image path. Press Enter to accept or enter a different path.
- The script restores the `.img` file to the selected SD card.

## Important Notes
- **Data Overwrite:** The restore process will overwrite all data on the destination SD card.
- **Drive Selection:** Carefully select the SD card to avoid data loss.
- **Root Access:** The script requires `sudo` to access drives directly.
- **Confirmation Required:** You must explicitly confirm the operation after the warning to proceed.

## Troubleshooting
- **Script Not Running:** Ensure the script is executable and you have `sudo` privileges.
- **Drive Not Detected:** Make sure the SD card is properly inserted and recognized by your system.

