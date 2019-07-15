USER_EMAIL=`git config user.email`
USER_NAME=`git config user.name`

if [ -z "$USER_EMAIL" ]; then
    read -p 'Please enter your email: ' USER_EMAIL
fi
if [ -z "$USER_NAME" ]; then
    read -p 'Please enter your full name: ' USER_NAME
fi

mv .gitconfig.bak .gitconfig
sed -i 's/<YOUR_EMAIL>/$USER_EMAIL' .gitconfig
sed -i 's/<YOUR_NAME>/$USER_NAME' .gitconfig

mv .dotfile-gitinfo .git/info

# Install basic things
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y vim-gnome git curl openssh-server

# Set vim as default editor
sudo update-alternatives --set editor /usr/bin/vim.gnome

# Install basic development packages
sudo apt install -y build-essential python-dev
sudo apt install -y python-pip python3-pip python-setuptools
pip install --user --upgrade virtualenv virtualenvwrapper

# Make VIM ASF
sudo apt intsall -y ruby-dev cowsay
`vim -c "PlugInstall|qa" > /dev/null 2>&1`

# Reset config from terminal and load saved config
dconf dump /org/gnome/terminal/ > /tmp/gnome_terminal_settings_backup.txt
dconf reset -f /org/gnome/terminal/
dconf load /org/gnome/terminal/ < .gnome_termianl_settings.txt

# Install Chrome (already set as default)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb

# Install useful stuff
sudo apt -y install vlc gnome-clocks meld

# Improve wrong password messages
sudo sed -i 's/#\s*Defaults\s\+insults/Defaults\tinsults/' /etc/sudoers

# Config gnome things
cp .dconf.bak /tmp/dconf.bak
sed -i 's/<YOUR_USERNAME>/$USER' /tmp/dconf.bak
dconf load / < /tmp/dconf.bak

# Clean all the things!
sudo apt -y autoremove
