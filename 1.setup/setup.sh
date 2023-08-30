#!/bin/bash

# Read hosts from the hosts.txt file (each line in the format: IP username password)
while IFS=' ' read -r ip username password; do
  # Generate SSH Key Pair
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""

  # Copy Public Key to Target Host
  scp ~/.ssh/id_rsa.pub "${username}@${ip}":/tmp/ansible_pubkey

  # Append Public Key to Authorized Keys on Target Host
  sshpass -p "${password}" ssh "${username}@${ip}" "cat /tmp/ansible_pubkey >> ~/.ssh/authorized_keys"

  # Perform Keyscan to Add Host to known_hosts
  ssh-keyscan -H ${ip} >> ~/.ssh/known_hosts

  echo "Finished setting up SSH for ${username}@${ip}"
done < hosts.txt
