#!/usr/bin/env bash

apt-get update

# Various Tools:
apt-get install -yq tree curl htop zip unzip 


# Python:
apt-get install -yq python python-dev python-pip
pip install virtualenv virtualenvwrapper -q


# Vim:
apt-get install -yq vim-nox
# Copy my config files (TODO: Replace with github repository):
cp /vagrant/.vimrc ~vagrant/
cp -r /vagrant/.vim ~vagrant/
chown vagrant: ~vagrant/.zshrc ~vagrant/.vimrc ~vagrant/.vim


# Git VCS:
apt-get install -yq git
#cd /vagrant
#git config branch.master.rebase true
#cd /tmp


# ZSH:
apt-get install -yq zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~vagrant/.oh-my-zsh
# Copy my config files (TODO: Replace with github repository):
cp /vagrant/.zshrc ~vagrant/
chown vagrant: ~vagrant/.zshrc
# Set zsh as default shell for user:
chsh -s /bin/zsh vagrant

# TODO install dotfiles from git repository
# Howto: http://blog.sanctum.geek.nz/managing-dot-files-with-git/
