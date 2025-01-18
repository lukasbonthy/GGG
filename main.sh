#!/bin/bash
echo "Starting BungeeCord server..."
cd bungee || { echo "Directory 'bungee' not found! Exiting."; exit 1; }

# Replace placeholder in config.yml with the SERVER environment variable
if [[ -f config.yml ]]; then
    sed -i 's/${SERVER}/'"$SERVER"'/g' config.yml
else
    echo "config.yml not found! Exiting."
    exit 1
fi

# Start the server in the background
java -Xmx1024M -Xms1024M -jar bungee.jar &
SERVER_PID=$!

# Wait for the server to initialize (adjust delay as needed)
sleep 10

# Send the verification command
echo "confirm-code 1ac4e20429" > /proc/$SERVER_PID/fd/0

# Keep the script running to monitor the server
wait $SERVER_PID
