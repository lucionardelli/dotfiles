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
sudo apt install -y vim curl openssh-server zsh
# sudo apt install -y vim-gtk curl openssh-server

# Set vim as default editor
sudo update-alternatives --set editor /usr/bin/vim
# sudo update-alternatives --set editor /usr/bin/vim-gtk3

# Install basic development packages
sudo apt install -y build-essential python3-dev
sudo apt install -y python3-pip python3-setuptools
sudo pip3 install --upgrade pip
pip3 install --user --upgrade virtualenv virtualenvwrapper
# Install Poetry
curl -sSL https://install.python-poetry.org | python3 -

# Install gnome-tweak-tools
sudo add-apt-repository universe
sudo apt install -y gnome-tweaks chrome-gnome-shell gnome-shell-extension gnome-shell-extension-prefs


# Make VIM AASF
sudo apt install -y ruby-dev cowsay
vim -c "PlugInstall|qa" > /dev/null 2>&1

# Install Chrome (already set as default)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb

# Install useful stuff (continue if some package cannot be found)
for pkg in vlc gnome-clocks meld xclip silversearcher-ag exuberant-ctags htop tig flake8 python-flake8 python3-flake8 clang-7 fzf bat; do
    sudo apt -y install $pkg
done

# Improve wrong password messages
sudo sed -i 's/#\s*Defaults\s\+insults/Defaults\tinsults/' /etc/sudoers


# I yield...use oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Reboot. But first...cleaning up my closet!
sudo apt autoremove
echo "You might want to...
 sudo reboot"
