# Install basic things
sudo apt update
sudo apt upgrade
sudo apt install -y vim-gnome git curl openssh-server

# Set vim as default editor
sudo update-alternatives --set editor /usr/bin/vim.gnome

# Install useful packages
sudo apt install -y build-essential python-dev
sudo apt install -y python-pip python3-pip python-setuptools
pip install --user --upgrade virtualenv virtualenvwrapper

# Reset config from terminal and load saved config
dconf dump /org/gnome/terminal/ > /tmp/gnome_terminal_settings_backup.txt
dconf reset -f /org/gnome/terminal/
dconf load /org/gnome/terminal/ < .gnome_termianl_settings.txt


# Install Chrome (should already by set as default)
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb

# Install VLC player
sudo apt -y install vlc
