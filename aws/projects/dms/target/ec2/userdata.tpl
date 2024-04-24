#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "Target" > /var/www/html/index.html
sudo service nginx start