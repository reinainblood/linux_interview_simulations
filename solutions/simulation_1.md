Simulation 1: high CPU usage

The script creates a few processes of the same name and type that run a 
CPU intensive funtion in a loop. Here's how I solved it:

1) run the 'top' command to see a list of all running processes and their CPU usage
2) since we have multiple that have sequential PIDs, we can kill them all with one
   command: kill {pid1..pid4}
3) if the PIDs weren't sequential but all processes had the same name, i would have
   used pkill -f name_of_process
   
