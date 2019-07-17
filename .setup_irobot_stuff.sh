#!/bin/bash

# iRobot's stuff

# Conect to the VPN
sudo apt install -y openconnect
sudo openconnect -b vpn.irobot.com

# Copy the irobot-gb VPN config to the correct location
sudo cp .irobot-gb.config /etc/NetworkManager/system-connections/irobot-gb
sudo chmod 0600 /etc/NetworkManager/system-connections/irobot-gb
sudo chown root:root /etc/NetworkManager/system-connections/irobot-gb


# Get SDK
wget https://hq-swtools.wardrobe.irobot.com/swtools-static/packages/brewst-sdk-install.sh -O /tmp/brewst-sdk-install.sh
chmod +x /tmp/brewst-sdk-install.sh
sudo /tmp/brewst-sdk-install.sh

# Get Slack and zoom
# This two lines are a patch...Need to seek the root cause of the error
sudo apt -y install libappindicator1
sudo apt -f install

dkpg-query -l slack*
if [ $? -ne 0 ]; then
    wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.4.2-amd64.deb -O /tmp/slack-desktop-3.4.2-amd64.deb
    sudo dpkg -i /tmp/slack-desktop-3.4.2-amd64.deb
fi

dkpg-query -l slack*
if [ $? -ne 0 ]; then
    wget https://zoom.us/client/latest/zoom_amd64.deb -O /tmp/zoom_amd64.deb
    sudo dpkg -i /tmp/zoom_amd64.deb
fi

# Install and configure icecc

dkpg-query -l icecc
if [ $? -ne 0 ]; then
    sudo apt install -y ccache icecc icecc-monitor
    sudo systemctl enable iceccd
    sudo sed -i 's/ICECC_ALLOW_REMOTE=.yes/ICECC_ALLOW_REMOTE="no/' /etc/icecc/icecc.conf > /dev/null 2>&1
fi

# Don't put everything in the home folder
if [ ! -d /irobot ]; then
    sudo mkdir /irobot
    sudo chown -R $USER:$USER /irobot
    ln -s /irobot $HOME/
fi
cd $HOME/irobot

# Check/create SSH key
CREATE_SSH_KEY='no'

if [ ! -f ~/.ssh/id_rsa.pub ]; then
    read -p "You don't have your ssh public key in the usual place.
             Maybe you don't even have an ssh key! Do you want us to create one for you? [y/N]" CREATE_SSH_KEY
fi

if [[ "$CREATE_SSH_KEY" =~ ^([yY][eE][sS]|[yY])+$ ]] ; then
    ssh-keygen -t rsa -b 4096 -C "$USER@irobot.com"
fi

echo "In order to continue you need to have your ssh key in Bitbucket."

read -p "Do you have the key already in bitbucket? [y/N]" KEY_IN_BB
if [[ ! "$KEY_IN_BB" =~ ^([yY][eE][sS]|[yY])+$ ]] ; then
    if [ ! -f ~/.ssh/id_rsa.pub ]; then
        echo "You don't have an ssh key in the usual location...sorry, but we give up!"
    else
        xclip -selection clipboard < ~/.ssh/id_rsa.pub
        echo " We already copied the public key to the clipboard (you're welcome!).
        Go and paste it in the browser that will popup and come back here when done (we'll miss you)"
        sleep 2
        xdg-open https://git.wardrobe.irobot.com/plugins/servlet/ssh/account/keys/add
        read -p "Do you have the key already in bitbucket? [y/N]" KEY_IN_BB
    fi
fi

if [[ ! "$KEY_IN_BB" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
    echo "Sorry, but we are done! We can't continue if you don't cooperate!"
    exit 1
fi

# Get the code
git clone --recurse-submodules --branch floorcare-dev ssh://git@git.wardrobe.irobot.com:7999/brewst/brewst.git $BREWST_HOME
git submodule update --init --recursive
git got get

# Get the wonderful VPN split routing script
git clone ssh://git@git.wardrobe.irobot.com:7999/~rrosa/vpn.git

