#! /bin/bash
username="app"
password="byonedekff"

sudo useradd -m $username
sudo adduser $username sudo
echo '$username:$password' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt-get update
sudo apt install wget
sudo apt install unzip
sudo wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip
sudo unzip ngrok-stable-linux-386.zip
sudo chmod 777 ngrok
sudo apt install openssh-server
sudo systemctl start sshd
sudo ./ngrok authtoken 1iHQbly9GkOsIQsGAjIxexO72q6_54DGhHzqVLNAPBpvHRpsy
sudo ./ngrok tcp 22
