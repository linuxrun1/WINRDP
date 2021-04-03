#! /bin/bash
username="app"
password="r"

sudo useradd -m $username
sudo adduser $username sudo
echo '$username:$password' | sudo chpasswd
sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd
sudo apt-get update
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sudo DEBIAN_FRONTEND=noninteractive \
apt install --assume-yes xfce4 desktop-base xfce4-terminal
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
sudo apt remove --assume-yes gnome-terminal
sudo apt install --assume-yes xscreensaver
sudo systemctl disable lightdm.service
sleep 3
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken
sleep 3
sudo apt install nautilus nano -y
sleep 3
CRP="DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AY0e-g41YoV9FwtUJFqY4yCy2E3LyE0ql2iiwNIQ7fGlHHmBfUPhN-ypXxRsxaAvRrKzRw" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)"
Pin="123456"
sudo adduser $username chrome-remote-desktop
su - $username -c """$CRP --pin=$Pin"""
