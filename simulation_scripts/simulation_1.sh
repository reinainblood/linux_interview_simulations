#!/bin/bash
##Explanation of the Script
  #Root Check: The script first checks if it's running as root, which isn't strictly necessary for this script but can be a good practice for operations that might affect system performance or stability.
  #CPU Load Simulation: The script uses the yes command combined with sha256sum to generate a constant stream of data being hashed. This is a simple way to create CPU load. The process is put in the background (&).
  #Monitoring and Cleanup: It advises using tools like top or htop to monitor the CPU usage and provides a command to kill the CPU-intensive processes when needed (pkill -f yes).
  #This simulated load can be useful for testing how well your system and its monitoring tools handle high CPU conditions. Adjust the TASK_COUNT to match or slightly exceed the number of CPU cores for more significant impact.

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

# Number of CPU-intensive tasks to spawn (modify based on your CPU cores)
TASK_COUNT=4

echo "Starting $TASK_COUNT CPU-intensive tasks to simulate high CPU usage..."

for i in $(seq 1 $TASK_COUNT)
do
   # Run a CPU-intensive command in the background
   # This uses the 'yes' command piped into 'sha256sum' to keep the CPU busy
   yes | sha256sum > /dev/null &
done

echo "CPU-intensive tasks are running in the background."
echo "Use 'top' or 'htop' to view CPU usage."

# Provide an option to kill the processes later
echo "To stop the CPU load, you can kill these processes using 'pkill -f yes' command."
