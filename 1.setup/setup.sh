#!/bin/bash

# Check if the server.txt file exists
if [ ! -f server.txt ]; then
  echo "server.txt file not found."
  exit 1
fi

# Loop through each line in server.txt
while IFS= read -r line; do
  # Split line into target host, username, and password
  target_host=$(echo "$line" | cut -d' ' -f1)
  target_username=$(echo "$line" | cut -d' ' -f2)
  target_password=$(echo "$line" | cut -d' ' -f3)

  echo "Setting up SSH keys for $target_username@$target_host"

  # Generate SSH key pair
  ssh-keygen -t rsa

  # Copy public key to target host using SSH and password
  sshpass -p "$target_password" ssh-copy-id -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa.pub "$target_username@$target_host"

  # Perform keyscan to add target host to known_hosts
  ssh-keyscan "$target_host" >> ~/.ssh/known_hosts

  echo "SSH key has been generated, copied to the target host, and keyscan completed for $target_username@$target_host"
  echo "---"
done < server.txt
