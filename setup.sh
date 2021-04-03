#! /bin/bash
username = "app"
password = "r"

print("Creating User and Setting it up")
sudo useradd -m $username &> /dev/null

sudo adduser $username sudo &> /dev/null

echo '$username:$password' | sudo chpasswd

sed -i 's/\/bin\/sh/\/bin\/bash/g' /etc/passwd


b='\033[1m'
r='\E[31m'
g='\E[32m'
c='\E[36m'
endc='\E[0m'
enda='\033[0m'

printf "\n\n$c$b    Loading Installer $endc$enda" >&2
if sudo apt-get update &> /dev/null
then
    printf "\r$g$b    Installer Loaded $endc$enda\n" >&2
else
    printf "\r$r$b    Error Occured $endc$enda\n" >&2
    exit
fi

printf "\n$g$b    Installing Chrome Remote Desktop $endc$enda" >&2
{
    wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
    sudo dpkg --install chrome-remote-desktop_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Chrome Remote Desktop Installed $endc$enda\n" >&2 ||
{ printf "\r$r$b    Error Occured $endc$enda\n" >&2; exit; }
sleep 3

printf "$g$b    Installing Desktop Environment $endc$enda" >&2
{
    sudo DEBIAN_FRONTEND=noninteractive \
        apt install --assume-yes xfce4 desktop-base xfce4-terminal
    sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'  
    sudo apt remove --assume-yes gnome-terminal
    sudo apt install --assume-yes xscreensaver
    sudo systemctl disable lightdm.service
} &> /dev/null &&
printf "\r$c$b    Desktop Environment Installed $endc$enda\n" >&2 ||
{ printf "\r$r$b    Error Occured $endc$enda\n" >&2; exit; }
sleep 3

printf "$g$b    Installing Google Chrome $endc$enda" >&2
{
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg --install google-chrome-stable_current_amd64.deb
    sudo apt install --assume-yes --fix-broken
} &> /dev/null &&
printf "\r$c$b    Google Chrome Installed $endc$enda\n" >&2 ||
printf "\r$r$b    Error Occured $endc$enda\n" >&2
sleep 3

printf "$g$b    Installing other Tools $endc$enda" >&2
if sudo apt install nautilus nano -y &> /dev/null
then
    printf "\r$c$b    Other Tools Installed $endc$enda\n" >&2
else
    printf "\r$r$b    Error Occured $endc$enda\n" >&2
fi
sleep 3

printf "\n$g$b    Installation Completed $endc$enda\n\n" >&2

CRP="DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AY0e-g41YoV9FwtUJFqY4yCy2E3LyE0ql2iiwNIQ7fGlHHmBfUPhN-ypXxRsxaAvRrKzRw" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)"
Pin="123456"

    sudo adduser $username chrome-remote-desktop &> /dev/null

    su - $username -c """$CRP --pin=$Pin""" &> /dev/null
