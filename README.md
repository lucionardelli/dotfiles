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
git remote add origin https://github.com/lucionardelli/dotfiles.git
git fetch
git reset origin/master --hard
git branch --set-upstream-to=origin/master master
git pull
source ~/.bashrc
```

### Install all packages(optional)

```sh
cd ~
sudo bash .setup_computer.sh
```


### TODO
 - Add images?
 - Create AdPlan specific config
 - TEST IT!
