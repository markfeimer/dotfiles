dotfiles
========

MarkF dotfiles

Instructions:

Get the repo and place it into ~/.dotfiles

Add the following to your .bash_profile

    source ~/.dotfiles/universal.sh

Create your ~/.dotfiles/localMachine.sh

    vim ~/.dotfiles/localMachine.sh

Symlink .vimrc:

    ln -s .dotfiles/.vimrc .vimrc

Symlink .vim

    ln -s .dotfiles/.vim .vim

Rejoice!

