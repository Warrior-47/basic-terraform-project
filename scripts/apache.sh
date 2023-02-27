#!/bin/bash

sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd --now

sudo echo "<h1>Hello from " > /var/www/html/index.html
curl 169.254.169.254/latest/meta-data/local-ipv4 >> /var/www/html/index.html
sudo echo "</h1>" >> /var/www/html/index.html