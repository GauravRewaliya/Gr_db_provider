#!/bin/bash

# Start docker-compose services in the background
docker compose -f docker-compose-db.yml up -d --remove-orphans
docker compose -f service/services/squid/docker-compose.yml up -d --remove-orphans

# Function to tail Squid logs
tail_squid_logs() {
  # Run the tail command without -it (no TTY needed)
  docker exec squid tail -f /var/log/squid/access.log &
  tail_pid=$!  # Capture the PID of the tail command
}

# Function to clean up and stop services on Ctrl+C
cleanup() {
  echo "Stopping services and cleaning up..."
  docker compose -f docker-compose-db.yml down
  docker compose -f service/services/squid/docker-compose.yml down

  # Kill the background tail process if it's still running
  if [ -n "$tail_pid" ]; then
    kill $tail_pid
  fi

  exit
}

# Trap SIGINT (Ctrl+C) to trigger cleanup function
trap cleanup SIGINT

# Start tailing Squid logs
tail_squid_logs

# Wait indefinitely until Ctrl+C is pressed
wait $tail_pid
