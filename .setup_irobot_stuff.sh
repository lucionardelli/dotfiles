# iRobot's stuff

# Conect to the VPN
sudo apt install -y openconnect
sudo openconnect -b vpn.irobot.com

# Get SDK
wget https://hq-swtools.wardrobe.irobot.com/swtools-static/packages/brewst-sdk-install.sh -O /tmp/brewst-sdk-install.sh
chmod +x /tmp/brewst-sdk-install.sh
sudo /tmp/brewst-sdk-install.sh

# Don't put everything in the home folder
sudo mkdir /irobot
sudo chown -R $USER:$USER /irobot
ln -s /irobot $HOME/
cd $HOME/irobot

# Get the code
git clone --recurse-submodules --branch floorcare-dev ssh://git@git.wardrobe.irobot.com:7999/brewst/brewst.git $BREWST_HOME
git submodule update --init --recursive
git got get

# Get the wonderful VPN split routing script
git clone ssh://git@git.wardrobe.irobot.com:7999/~rrosa/vpn.git

# Copy the irobot-bg VPN config to the correct location
sudo cp .irobot-gb.config /etc/NetworkManager/system-connections/irobot-gb
sudo chmod 0600 /etc/NetworkManager/system-connections/irobot-gb
sudo chown root:root /etc/NetworkManager/system-connections/irobot-gb

# Get Slack and zoom
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-3.4.2-amd64.deb -O /tmp/slack-desktop-3.4.2-amd64.deb
sudo dpkg -i /tmp/slack-desktop-3.4.2-amd64.deb
wget https://zoom.us/client/latest/zoom_amd64.deb -O /tmp/zoom_amd64.deb
sudo dpkg -i /tmp/zoom_amd64.deb

# Install and configure icecc
sudo apt install -y ccache icecc icecc-monitor
sudo systemctl enable iceccd
sudo sed -i 's/ICECC_ALLOW_REMOTE=.yes/ICECC_ALLOW_REMOTE="no/' /etc/icecc/icecc.conf > /dev/null 2>&1
