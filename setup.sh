#!/bin/bash

DFD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NOW=`date +"%Y_%m_%d_%H_%M_%S"`
source $DFD/.env.sh

function backup_and_link() {
	# usage: backup_and_link <prjfilename> [<sysfilename>]
	arg1="$1"
	arg2="$1"
	if [ "$2" ]; then
		arg2="$2"
	fi

	if [ -f $HOME/$arg2 ]; then
	        mv $HOME/$arg2 $HOME/$arg2_$NOW
	fi
	ln -s $DFD/$arg1 $HOME/$arg2
}

# link scripts
if [[ "$ENV_UNAMESTR" == 'Darwin' ]]; then
	backup_and_link .bash_profile
else
	backup_and_link .bash_profile .bashrc
fi
backup_and_link .gdbinit
backup_and_link .vimrc

source $DFD/.bash_aliases

# git
if command_exists git ; then
	git config --global alias.st status 
	git config --global alias.ci 'commit -v'
	git config --global alias.lg 'log --name-status --decorate'
	git config --global alias.lg2 "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
	git config --global alias.br branch
	git config --global color.ui true
fi
