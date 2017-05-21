dotfiles
========

MarkF dotfiles

Instructions:

Get the repo and place it into ~/.dotfiles

Add the following to your CLI profile (usually `.bash_profile` or `.profile`)

    source ~/dotfiles/universal.sh

Create your ~/dotfiles/localMachine.sh

    vim ~/dotfiles/localMachine.sh

Symlink .vimrc:

    ln -s dotfiles/.vimrc .vimrc

Symlink .vim

    ln -s dotfiles/.vim .vim

Rejoice!

