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

## Additional Utilities

### PiShrink

After creating a backup image with this script, you might find the image file is quite large, especially if the SD card was not fully utilized. To reduce the size of the image file, you can use PiShrink. PiShrink is a tool that automatically shrinks a Pi image that will then resize to the max size of the SD card on boot.

#### Using PiShrink

1. **Download and Installation**:
   Clone the PiShrink repository from GitHub and make the script executable:
   ```bash
   git clone https://github.com/Drewsif/PiShrink.git
   cd PiShrink
   chmod +x pishrink.sh
   ```

2. **Run PiShrink**:
   Use the following command to shrink your Raspberry Pi image:
   ```bash
   sudo ./pishrink.sh path_to_your_image.img
   ```
   If you want to specify a new filename for the shrunk image:
   ```bash
   sudo ./pishrink.sh path_to_your_image.img new_shrunk_image.img
   ```

   PiShrink will automatically enable the image to expand to its maximum size on the first boot unless you use the `-s` option to disable this feature.

3. **Options**:
   - Disable auto-expand: `sudo ./pishrink.sh -s path_to_your_image.img`
   - Verbose mode: `sudo ./pishrink.sh -v path_to_your_image.img`

For more information and updates, visit the [PiShrink GitHub page](https://github.com/Drewsif/PiShrink).

#### Note:
Always ensure you have a backup of your original image file before using PiShrink or any modification tools to avoid accidental data loss.
