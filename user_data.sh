#!bin/bash
sudo apt update && apt upgrade -y
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh)"
grep "apiUrl" /var/log/cloud-init-output.log  >> /tmp/outline-install-details.txt