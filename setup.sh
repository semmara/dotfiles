#!/bin/bash

DFD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOW=`date +"%Y_%m_%d_%H_%M_%S"`

function backup_and_link() {
	if [ -f $HOME/$1 ]; then
	        mv $HOME/$1 $HOME/$1_$NOW
	fi
	ln -s $DFD/$1 $HOME/$1
}

backup_and_link .bash_profile
backup_and_link .gdbinit
backup_and_link .vimrc

source $DFD/.bash_aliases

# git
if command_exists git ; then
	git config --global alias.st status 
	git config --global alias.ci 'commit -v'
	git config --global alias.lg 'log --name-status --decorate'
fi
