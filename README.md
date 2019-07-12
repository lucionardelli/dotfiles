# Lucio's Dotfiles
##### (Inspired by https://github.com/nachovizzo/dotfiles/)

### Prerequisites
To run this, you need to have git installed and configured:

```sh
sudo apt update
sudo apt upgrade
sudo apt install git
git config --global user.name <YOUR NAME>
git config --global user.email <YOUR EMAIL@EXAMPLE.COM>
```

### Init the dotfile repository into your home directory

```sh
git init
git remote add origin git@github.com:lucionardelli/dotfiles.git
git fetch
git reset origin/master --hard
git pull origin master
```

### Install all packages(optional)

```sh
cd ~
sudo sh .setup_computer.sh
```


### TODO
 - Add images?
 - Create AdPlan specific config
 - TEST IT!

 - Do this in a different file .setup_irobot
 - iRobot VPN can't be run in the same terminal (--background option? -u "username")
 - checkout irobot's vpn repo (ssh://git@git.wardrobe.irobot.com:7999/~rrosa/vpn.git)
 - Configure irobot-bg vpn as per above repo
