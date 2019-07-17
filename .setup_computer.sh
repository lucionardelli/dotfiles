#! /bin/bash

# Setup all the things!

USER_EMAIL=`git config --global user.email`
USER_NAME=`git config --global user.name`

if [ -z "$USER_EMAIL" ]; then
    read -p 'Please enter your email: ' USER_EMAIL
fi
if [ -z "$USER_NAME" ]; then
    read -p 'Please enter your full name: ' USER_NAME
fi

cp .gitconfig.bak .gitconfig
git config --global user.email $USER_EMAIL
git config --global user.name $USER_NAME

rm -rf .git/info
cp -r .dotfile-gitinfo .git/info

# Install basic things
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y vim-gnome curl openssh-server

# Set vim as default editor
sudo update-alternatives --set editor /usr/bin/vim.gnome

# Install basic development packages
sudo apt install -y build-essential python-dev python3-dev
sudo apt install -y python-pip python3-pip python3-setuptools
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip
pip install --user --upgrade virtualenv virtualenvwrapper
pip3 install --user --upgrade virtualenv virtualenvwrapper


# Make VIM ASF
sudo apt install -y ruby-dev cowsay
vim -c "PlugInstall|qa" > /dev/null 2>&1

# Install Chrome (already set as default)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb

# Install useful stuff
sudo apt -y install vlc gnome-clocks meld xclip

# Improve wrong password messages
sudo sed -i 's/#\s*Defaults\s\+insults/Defaults\tinsults/' /etc/sudoers

# Config gnome things
cp .dconf.bak /tmp/dconf.bak
sed -i "s/<YOUR_USERNAME>/$USER/" /tmp/dconf.bak
dconf reset -f /
dconf load / < /tmp/dconf.bak

# Reboot. But first...cleaning up my closet!
sudo apt autoremove
echo "You might want to...
 sudo reboot"
