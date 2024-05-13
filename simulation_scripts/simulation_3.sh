#!/bin/bash
## Ok, now let's rerun the script from simulation 2 except throw a wrench in our plans to delete the file
## by setting it as immutable

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

# Directory to place the large file
STORAGE_DIR="/var/tmp"
# Large file name
LARGE_FILE="large_test_file.img"

# Check available disk space before creating the file
AVAILABLE_SPACE=$(df "$STORAGE_DIR" | awk 'NR==2 {print $4}')  # space available in KB
FILE_SIZE_KB=$(echo "$AVAILABLE_SPACE * 0.98" | bc | cut -d'.' -f1)

# Create a large file by filling it with zero bytes
function create_large_file {
    # Size of the file in megabytes
    FILE_SIZE_KB=$FILE_SIZE_KB  # Adjust this size according to your needs and free space

    echo "Creating a $FILE_SIZE_KB KB file in $STORAGE_DIR..."
    dd if=/dev/zero of="$STORAGE_DIR/$LARGE_FILE" bs=1K count=$FILE_SIZE_KB status=progress
    echo "File created: $STORAGE_DIR/$LARGE_FILE"
    sudo chattr +i "$STORAGE_DIR/$LARGE_FILE"
}

# Comparison using awk
COMPARATOR=$(awk -v a="$AVAILABLE_SPACE" -v b="$FILE_SIZE_KB" 'BEGIN { print (a > b) ? "YES" : "NO" }')
if [ "$COMPARATOR" = "NO" ]; then
    echo "Not enough disk space available in $STORAGE_DIR to create the file."
    exit 1
else
    create_large_file
fi

# Reminder to clean up
echo "Remember to delete the large file when done testing: rm $STORAGE_DIR/$LARGE_FILE"
