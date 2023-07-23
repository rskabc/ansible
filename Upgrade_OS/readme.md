If you don’t want to use password authentication make sure ssh public key is copied to the servers:
$ ssh-copy-id root@159.89.238.38 #replace root with your ssh user & correct IP
$ ssh-copy-id root@192.34.58.254 #replace root with your ssh user & correct IP

Check playbook syntax before execution:
$ ansible-playbook --syntax-check upgrade_reboot.yml -i hosts
playbook: upgrade_reboot.yml

Once the key is copied, run the playbook:
$ ansible-playbook -i hosts upgrade_reboot.yml
