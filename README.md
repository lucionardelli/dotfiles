# Lucio's Dotfiles (Inspired by https://github.com/nachovizzo/dotfiles/)

## Init the dotfile repository into your home directory

```sh
git init
git remote add origin git@github.com:lucionardelli/dotfiles.git
git fetch
git reset origin/master --hard
git pull origin master
```

## Install all packages(optional)

```sh
sudo apt update && cat pkglist | xargs sudo apt install
```
