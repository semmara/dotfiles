#!/bin/bash

DFD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOW=`date +"%Y_%m_%d_%H_%M_%S"`

function backup_and_link() {
	if [ -f $HOME/$1 ]; then
	        mv $HOME/$1 $HOME/$1_$NOW
	fi
	ln -s $DFD/$1 $HOME/$1
}

# .bash_profile
#if [ -f $HOME/.bash_profile ]; then
#	mv $HOME/.bash_profile $HOME/.bash_profile_$NOW
#fi
#ln -s $DFD/.bash_profile $HOME/.bash_profile
backup_and_link .bash_profile
backup_and_link .gdbinit
backup_and_link .vimrc

