#!/usr/bin/env bash

apt-get update --fix-missing

# Various Tools:
apt-get install -yq tree curl htop zip unzip tmux dtrx


# Python:
apt-get install -yq python python-dev python-pip
pip install virtualenv virtualenvwrapper -q


# Vim:
apt-get install -yq vim-nox


# Git VCS:
apt-get install -yq git
#cd /vagrant
#git config branch.master.rebase true
#cd /tmp


# ZSH:
apt-get install -yq zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~vagrant/.oh-my-zsh
# Set zsh as default shell for user:
chsh -s /bin/zsh vagrant


# Install dotfiles from git repository:
# Howto: http://blog.sanctum.geek.nz/managing-dot-files-with-git/
# Clone dotfiles
git clone git://github.com/chrischmo/dotfiles.git ~vagrant/.dotfiles
# Set up dotfiles repository URL correctly to allow for pushing to it later
cd ~vagrant/.dotfiles
git remote set-url origin git@github.com:chrischmo/dotfiles.git
# Initialize & update submodules
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update
# Set correct permissions for dotfiles-folder
chown -R vagrant: ~vagrant/.dotfiles
# Clean up possibly existing dotfiles
cd ~vagrant/
rm -r .vim .vimrc .gitconfig .zshrc
# Create links in homefolder
ln -s ~vagrant/.dotfiles/vim ~vagrant/.vim
ln -s ~vagrant/.dotfiles/vimrc ~vagrant/.vimrc
ln -s ~vagrant/.dotfiles/gitconfig ~vagrant/.gitconfig
ln -s ~vagrant/.dotfiles/zshrc ~vagrant/.zshrc
# Set correct permissions for links to dotfiles
chown vagrant: ~vagrant/.zshrc ~vagrant/.vimrc ~vagrant/.vim ~vagrant/.gitconfig

# Copy SSH keys from /vagrant
cp /vagrant/.ssh_keys/id_rsa* ~vagrant/.ssh
chown vagrant: .ssh/id_rsa*
chmod 600 ~vagrant/.ssh/id_rsa
chmod 644 ~vagrant/.ssh/id_rsa.pub

# Final Messages:
echo -e "\n======================= To-Do POST-INSTALL: =========================\n"
echo -e "Manually add the SSH key to ssh-agent (can't be done automatically \n\
because passphrase has to be entered). Execute the following command \n\
first to prevent the 'Could not open a connection to your \n\
authentication agent.' error:"
echo -e "    eval <DOLLAR>(ssh-agent) \n\
    ssh-add ~vagrant/.ssh/id_rsa\n"

echo -e "---------------------------------------------------------------------\n"

echo -e "OPTIONAL: Update the vim plugins by cd-ing into .dotfiles & running:"
echo -e "    git submodule foreach git pull origin master"
echo -e "    git push"
echo -e "===================================================================="
